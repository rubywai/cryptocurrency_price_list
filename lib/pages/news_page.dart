import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/notifiers/news/news_state_model.dart';
import 'package:crypto_price_list/notifiers/news/news_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/news_item_widget.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  final NewsProvider _provider = NewsProvider(() => NewsStateNotifier());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsStateModel newsStateModel = ref.watch(_provider);
    int count = newsStateModel.newsModel?.articles?.length ?? 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (newsStateModel.isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (newsStateModel.isSuccess == true &&
            newsStateModel.isLoading == false)
          Expanded(
            child: ListView.builder(
              itemCount: count + 1,
              itemBuilder: (context, index) {
                if (index == newsStateModel.newsModel?.totalResults) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    child: Text("Nothing to load"),
                  );
                } else if (index == count) {
                  ref.read(_provider.notifier).loadMore();
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  );
                }
                Articles? article = newsStateModel.newsModel?.articles?[index];

                return NewsItemWidget(
                  article: article,
                );
              },
            ),
          ),
      ],
    );
  }
}
