import 'package:crypto_price_list/widgets/iframe_viewer/iframe_viewer_common.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({
    super.key,
    required this.title,
    required this.link,
  });
  final String title;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: IframeViewer(link: link),
    );
  }
}
