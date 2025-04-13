import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../const/url_const.dart';
import '../../const/utils.dart';
import '../models/price_model.dart';

class PriceApiServices {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: UrlConst.baseUrl),
  )..interceptors.add(PrettyDioLogger());
  Future<List<PriceModel>> getPriceList({
    String currency = 'usd',
    required int page,
    String? order,
  }) async {
    Map<String, String>? orderMap = order == null
        ? null
        : {
            'order': order,
          };
    final response = await _dio.get(UrlConst.list, queryParameters: {
      'vs_currency': currency,
      'price_change_percentage': '1h,24h,7d',
      'per_page': Utils.perPage,
      'page': page,
      ...orderMap ?? {},
    });
    return (response.data as List).map((e) {
      return PriceModel.fromJson(e);
    }).toList();
  }
}
