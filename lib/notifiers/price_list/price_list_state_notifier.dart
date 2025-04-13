import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/price_model.dart';
import '../../data/services/price_api_services.dart';
import 'price_list_state_model.dart';

typedef PriceListProvider
    = NotifierProvider<PriceListStateNotifier, PriceListStateModel>;

class PriceListStateNotifier extends Notifier<PriceListStateModel> {
  final PriceApiServices _apiServices = PriceApiServices();
  int _page = 1;
  @override
  PriceListStateModel build() {
    return PriceListStateModel();
  }

  Future<void> getPriceList() async {
    try {
      state = state.copWith(
        loading: true,
        errorMessage: '',
        success: false,
      );

      List<PriceModel> priceList = await _apiServices.getPriceList(page: _page);
      state = state.copWith(
        priceList: priceList,
        success: true,
        loading: false,
      );
    } catch (e) {
      state = state.copWith(
        loading: false,
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  void loadMore() async {
    _page = _page + 1;
    try {
      List<PriceModel> newList = await _apiServices.getPriceList(page: _page);
      state = state.copWith(priceList: [
        ...state.priceList,
        ...newList,
      ]);
    } catch (e) {
      //
    }
  }
}
