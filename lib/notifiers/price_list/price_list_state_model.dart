import '../../data/models/price_model.dart';

class PriceListStateModel {
  final List<PriceModel> priceList;
  final bool isPaginate;
  final bool loading;
  final bool success;
  final String? errorMessage;
  PriceListStateModel({
    this.isPaginate = false,
    this.priceList = const [],
    this.loading = true,
    this.success = false,
    this.errorMessage,
  });

  PriceListStateModel copWith({
    List<PriceModel>? priceList,
    bool? isPaginate,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return PriceListStateModel(
      priceList: priceList ?? this.priceList,
      isPaginate: isPaginate ?? this.isPaginate,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
