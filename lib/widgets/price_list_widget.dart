import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_model.dart';
import '../notifiers/price_list/price_list_state_model.dart';
import '../notifiers/price_list/price_list_state_notifier.dart';
import 'price_item_desktop_widget.dart';
import 'price_item_mobile_widget.dart';

class PriceListWidget extends ConsumerWidget {
  PriceListWidget({
    super.key,
    required this.priceListProvider,
    this.isFav = false,
  });

  final PriceListProvider priceListProvider;
  final bool isFav;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    double width = MediaQuery.of(context).size.width;
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList =
        isFav ? stateModel.favList : stateModel.priceList;
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
              child: priceList.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          isFav ? priceList.length : priceList.length + 1,
                      itemBuilder: (context, position) {
                        if (position == priceList.length) {
                          ref.read(priceListProvider.notifier).loadMore();
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          );
                        }
                        PriceModel priceModel = priceList[position];
                        return PriceItemMobile(
                          priceModel: priceModel,
                        );
                      },
                    )
                  : Center(
                      child: Text('Empty Favourite'),
                    ),
            ),
          ),
        if (stateModel.success && !stateModel.loading && width >= 600)
          Expanded(
            child: priceList.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1300,
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
                                itemCount: isFav
                                    ? priceList.length
                                    : priceList.length + 1,
                                itemBuilder: (context, position) {
                                  if (position == priceList.length) {
                                    ref
                                        .read(priceListProvider.notifier)
                                        .loadMore();
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8.0),
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
                  )
                : Center(
                    child: Text('Empty Favourite'),
                  ),
          ),
      ],
    );
  }
}
