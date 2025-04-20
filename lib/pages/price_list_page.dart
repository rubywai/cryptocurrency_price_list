import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_model.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_notifier.dart';
import 'package:crypto_price_list/widgets/price_item_desktop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/price_item_mobile_widget.dart';

class PriceListPage extends ConsumerStatefulWidget {
  const PriceListPage({super.key});

  @override
  ConsumerState<PriceListPage> createState() => _PriceListPageState();
}

class _PriceListPageState extends ConsumerState<PriceListPage> {
  final priceListProvider = PriceListProvider(
    () => PriceListStateNotifier(),
  );
  final ScrollController _controller = ScrollController();
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
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (stateModel.loading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (stateModel.success && !stateModel.loading && width < 600)
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
                  return PriceItemMobile(
                    priceModel: priceModel,
                  );
                },
              ),
            ),
          ),
        if (stateModel.success && !stateModel.loading && width >= 600)
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 8.0),
                      width: 200,
                      child: Text('Name'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 100,
                      child: Text('Symbol'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 150,
                      child: Text('Current Price'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 100,
                      child: Text('1-hr change'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 150,
                      child: Text('24-hr change'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 150,
                      child: Text('7-ds change'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 200,
                      child: Text('24-hr volume'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(right: 8.0),
                      width: 200,
                      child: Text('Market cup'),
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    controller: _controller,
                    trackVisibility: true,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: priceList.length + 1,
                      itemBuilder: (context, position) {
                        if (position == priceList.length) {
                          ref.read(priceListProvider.notifier).loadMore();
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        PriceModel priceModel = priceList[position];
                        return PriceItemDesktopWidget(
                          priceModel: priceModel,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
