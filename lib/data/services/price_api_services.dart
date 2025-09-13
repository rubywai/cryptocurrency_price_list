import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../const/url_const.dart';
import '../../const/utils.dart';
import '../models/price_model.dart';

class PriceApiServices {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'price');
  Future<List<PriceModel>> getPriceList({
    String currency = 'usd',
    required int page,
    int? perPage = Utils.perPage,
    String? order,
    List<String> ids = const [],
  }) async {
    Map<String, String>? orderMap = order == null || order.isEmpty
        ? null
        : {
            'order': order,
          };
    if (ids.isNotEmpty) {
      orderMap ??= {};
      orderMap['ids'] = ids.join(',');
    }
    if (ids.isEmpty) {
      orderMap ??= {};
      orderMap = {
        ...orderMap,
        'per_page': perPage.toString(),
        'page': page.toString(),
      };
    }
    final response = await _dio.get(
      UrlConst.list,
      queryParameters: {
        'vs_currency': currency,
        'price_change_percentage': '1h,24h,7d',
        ...orderMap ?? {},
      },
    );
    return (response.data as List).map((e) {
      return PriceModel.fromJson(e);
    }).toList();
  }
}
