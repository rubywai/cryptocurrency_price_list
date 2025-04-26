import 'package:crypto_price_list/const/favourite_utils.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/url_const.dart';

Future<void> setupLocator() async {
  GetIt getIt = GetIt.instance;
  //shared preferences
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preferences);
  //dio price list
  Dio dio = Dio(
    BaseOptions(baseUrl: UrlConst.baseUrl),
  );
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(dio, instanceName: 'price');

  //dio news list
  Dio dioNews = Dio(
    BaseOptions(baseUrl: UrlConst.newsUrl),
  );
  dioNews.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton(dioNews, instanceName: 'news');
  //favourite utils
  FavouriteUtils utils = FavouriteUtils();
  getIt.registerSingleton<FavouriteUtils>(utils);
}
