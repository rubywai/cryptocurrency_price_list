import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/price_item_widget.dart';

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cryptocurrency Price List'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              ref.read(priceListProvider.notifier).sort(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: '',
                  child: Text('Default'),
                ),
                PopupMenuItem<String>(
                  value: 'market_cap_asc',
                  child: Text('Asc (Market cap)'),
                ),
                PopupMenuItem<String>(
                  value: 'market_cap_desc',
                  child: Text('Desc (Market cap)'),
                ),
                PopupMenuItem<String>(
                  value: 'volume_asc',
                  child: Text('Asc (24 hours volume)'),
                ),
                PopupMenuItem<String>(
                  value: 'volume_desc',
                  child: Text('Desc (24 hours volume)'),
                ),
              ];
            },
          )
        ],
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
                    return PriceItem(
                      priceModel: priceModel,
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
