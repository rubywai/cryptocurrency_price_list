import 'package:crypto_price_list/const/favourite_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../const/url_const.dart';
import '../../data/models/detail_model.dart';
import '../../data/wss/detail_wss_service.dart';
import 'price_detail_state_model.dart';

typedef PriceDetailProvider
    = AutoDisposeNotifierProvider<PriceDetailNotifier, PriceDetailStateModel>;

class PriceDetailNotifier extends AutoDisposeNotifier<PriceDetailStateModel> {
  final DetailWssService _wssService = DetailWssService();
  final SharedPrefsUtils _favouriteUtils = GetIt.I.get<SharedPrefsUtils>();
  @override
  PriceDetailStateModel build() {
    _wssService.connect();
    ref.onDispose(() {
      _dispose();
    });
    return PriceDetailStateModel();
  }

  void clearFavourite() {
    _favouriteUtils.clearFavourites();
  }

  void addFavourite(String code) {
    _favouriteUtils.saveFavourite(code);
    bool isFav = _favouriteUtils.isFavourite(code);
    state = state.copyWith(isFavourite: isFav);
  }

  void removeFavourite(String code) {
    _favouriteUtils.removeFavourite(code);
    bool isFav = _favouriteUtils.isFavourite(code);
    state = state.copyWith(isFavourite: isFav);
  }

  void getUpdatedPrice(String symbol, String name) {
    _wssService.sendMessage(UrlConst.getWssMessage(symbol));
    Stream<DetailModel>? detailStream = _wssService.getUpdatedPrice();
    bool isFav = _favouriteUtils.isFavourite(name);
    state = state.copyWith(isFavourite: isFav);
    detailStream?.listen(
      (price) {
        state = state.copyWith(
          currentPrice: num.tryParse(price.price ?? ''),
          bidPrice: num.tryParse(price.bestBid ?? ''),
          sellPrice: num.tryParse(price.bestAsk ?? ''),
          time: DateTime.tryParse(price.time ?? ''),
        );
      },
    ).onError((e) {
      print('error $e');
    });
  }

  void _dispose() {
    _wssService.disconnect();
  }
}
