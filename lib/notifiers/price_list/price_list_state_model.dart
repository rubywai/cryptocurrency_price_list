import '../../data/models/price_model.dart';

class PriceListStateModel {
  final List<PriceModel> priceList;
  final List<PriceModel> favList;
  final bool isPaginate;
  final bool loading;
  final bool success;
  final String? errorMessage;
  PriceListStateModel({
    this.isPaginate = false,
    this.priceList = const [],
    this.favList = const [],
    this.loading = true,
    this.success = false,
    this.errorMessage,
  });

  PriceListStateModel copWith({
    List<PriceModel>? priceList,
    List<PriceModel>? favList,
    bool? isPaginate,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return PriceListStateModel(
      priceList: priceList ?? this.priceList,
      favList: favList ?? this.favList,
      isPaginate: isPaginate ?? this.isPaginate,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
