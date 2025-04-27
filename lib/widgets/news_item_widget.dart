import 'package:crypto_price_list/pages/news_detail_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/news_model.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({
    super.key,
    required this.article,
  });

  final Articles? article;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    DateTime? date = DateTime.tryParse(article?.publishedAt ?? '');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (kIsWeb) {
            launchUrl(Uri.parse(article?.url ?? ''));
          } else {
            Navigator.of(context, rootNavigator: false).push(
              MaterialPageRoute(
                builder: (_) {
                  return NewsDetailPage(
                    title: article?.title ?? '',
                    link: article?.url ?? '',
                  );
                },
              ),
            );
          }
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article?.urlToImage != null)
                Stack(
                  children: [
                    Image.network(
                      article!.urlToImage!,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) {
                        return SizedBox.shrink();
                      },
                    ),
                    Container(
                      color: Colors.black.withAlpha(80),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        article?.source?.name ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      article?.title ?? '',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      article?.description ?? '',
                      style: textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(),
                    if (date != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}',
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              SharePlus.instance.share(
                                ShareParams(
                                  uri: Uri.parse(article?.url ?? ''),
                                ),
                              );
                            },
                            icon: Icon(Icons.share),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
