import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/notifiers/price_detail/price_detail_notifier.dart';
import 'package:crypto_price_list/notifiers/price_detail/price_detail_state_model.dart';
import 'package:crypto_price_list/widgets/detail_price_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/iframe_viewer/iframe_viewer_common.dart';

class PriceDetailPage extends ConsumerStatefulWidget {
  const PriceDetailPage({
    super.key,
    required this.symbol,
    required this.name,
  });
  final String symbol;
  final String name;

  @override
  ConsumerState<PriceDetailPage> createState() => _PriceDetailPageState();
}

class _PriceDetailPageState extends ConsumerState<PriceDetailPage> {
  final PriceDetailProvider _detailProvider = PriceDetailProvider(
    () => PriceDetailNotifier(),
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(_detailProvider.notifier)
          .getUpdatedPrice(widget.symbol.toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    String chartUrl =
        '${UrlConst.charUrl}${widget.symbol.toUpperCase()}USD${UrlConst.chartQuery}';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: IframeViewer(link: chartUrl),
          ),
          Consumer(builder: (context, ref, child) {
            PriceDetailStateModel model = ref.watch(_detailProvider);
            DateTime? date = model.time;
            return Column(
              children: [
                DetailPriceItem(
                  title: 'Current Price',
                  value: model.currentPrice?.toString() ?? '',
                ),
                DetailPriceItem(
                  title: 'Bid Price',
                  value: model.bidPrice?.toString() ?? '',
                ),
                DetailPriceItem(
                  title: 'Ask Price',
                  value: model.sellPrice?.toString() ?? '',
                ),
                DetailPriceItem(
                  title: 'Updated at',
                  value:
                      '${date?.day}-${date?.month}-${date?.year} ${date?.hour}:${date?.minute}',
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
