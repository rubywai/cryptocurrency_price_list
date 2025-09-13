import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/data/services/news_api_services.dart';
import 'package:crypto_price_list/notifiers/news/news_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef NewsProvider = NotifierProvider<NewsStateNotifier, NewsStateModel>;

class NewsStateNotifier extends Notifier<NewsStateModel> {
  final NewsApiService _apiService = NewsApiService();
  int _page = 1;
  @override
  NewsStateModel build() {
    return NewsStateModel();
  }

  void getNews() async {
    try {
      state = state.copWith(
        isLoading: true,
        isSuccess: false,
        isError: false,
      );
      NewsModel newsModel = await _apiService.getNews();
      state = state.copWith(
        newsModel: newsModel,
        isLoading: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copWith(
        isLoading: false,
        isError: false,
      );
    }
  }

  void loadMore() async {
    try {
      _page = _page + 1;
      NewsModel newsModel1 = await _apiService.getNews(page: _page);
      state = state.copWith(
          newsModel: state.newsModel?.copyWith(
        articles: [
          ...state.newsModel?.articles ?? [],
          ...newsModel1.articles ?? [],
        ],
      ));
    } catch (e) {
      //
    }
  }
}
