import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceListPage extends ConsumerStatefulWidget {
  const PriceListPage({super.key});

  @override
  ConsumerState<PriceListPage> createState() => _PriceListPageState();
}

class _PriceListPageState extends ConsumerState<PriceListPage> {
  final priceListProvider = PriceListProvider(
    () => PriceListStateNotifier(),
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(priceListProvider.notifier).getPriceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList = stateModel.priceList;

    TextTheme textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cryptocurrency Price List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (stateModel.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (stateModel.success && !stateModel.loading)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: priceList.length + 1,
                  itemBuilder: (context, position) {
                    if (position == priceList.length) {
                      ref.read(priceListProvider.notifier).loadMore();
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    PriceModel priceModel = priceList[position];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      if (priceModel.image != null)
                                        Image.network(
                                          priceModel.image!,
                                          width: 25,
                                        ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Flexible(
                                        child: Text(
                                          priceModel.name ?? '',
                                          style: textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    priceModel.symbol?.toUpperCase() ?? '',
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        '\$${priceModel.currentPrice?.toStringAsFixed(2) ?? ''}'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text('1h'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('24h'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('7d'),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('24 hr volume'),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('Market Cap'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(priceModel
                                          .priceChangePercentage1hInCurrency
                                          ?.toStringAsFixed(1) ??
                                      ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(priceModel
                                          .priceChangePercentage24hInCurrency
                                          ?.toStringAsFixed(1) ??
                                      ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(priceModel
                                          .priceChangePercentage7dInCurrency
                                          ?.toStringAsFixed(1) ??
                                      ''),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                      priceModel.totalVolume?.toString() ?? ''),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                      priceModel.marketCap?.toString() ?? ''),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
