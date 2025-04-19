import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/url_const.dart';
import '../../data/models/detail_model.dart';
import '../../data/wss/detail_wss_service.dart';
import 'price_detail_state_model.dart';

typedef PriceDetailProvider
    = AutoDisposeNotifierProvider<PriceDetailNotifier, PriceDetailStateModel>;

class PriceDetailNotifier extends AutoDisposeNotifier<PriceDetailStateModel> {
  final DetailWssService _wssService = DetailWssService();
  @override
  PriceDetailStateModel build() {
    _wssService.connect();
    return PriceDetailStateModel();
  }

  void getUpdatedPrice(String symbol) {
    _wssService.sendMessage(UrlConst.getWssMessage(symbol));
    Stream<DetailModel>? detailStream = _wssService.getUpdatedPrice();
    detailStream?.listen(
      (price) {
        state = state.copyWith(
            currentPrice: num.tryParse(price.price ?? ''),
            bidPrice: num.tryParse(price.bestBid ?? ''),
            sellPrice: num.tryParse(price.bestAsk ?? ''),
            time: DateTime.tryParse(price.time ?? ''));
      },
    ).onError((e) {
      print('error $e');
    });
  }

  void dispose() {
    _wssService.disconnect();
  }
}
