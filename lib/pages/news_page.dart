import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/notifiers/news/news_state_model.dart';
import 'package:crypto_price_list/notifiers/news/news_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        if (newsStateModel.isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (newsStateModel.isSuccess == true &&
            newsStateModel.isLoading == false)
          Expanded(
            child: ListView.builder(
              itemCount: newsStateModel.newsModel?.articles?.length ?? 0,
              itemBuilder: (context, index) {
                Articles? article = newsStateModel.newsModel?.articles?[index];
                DateTime? date = DateTime.tryParse(article?.publishedAt ?? '');
                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article?.urlToImage != null)
                        Image.network(
                          article!.urlToImage!,
                          width: 100,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article?.title ?? '',
                              style: textTheme.titleLarge,
                            ),
                            Text(
                              article?.description ?? '',
                              style: textTheme.bodyMedium,
                            ),
                            if (date != null)
                              Text(
                                  '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}')
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
