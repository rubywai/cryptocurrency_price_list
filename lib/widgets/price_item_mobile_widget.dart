import 'package:crypto_price_list/pages/price_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/indicator_color.dart';
import '../const/number_utils.dart';
import '../data/models/price_model.dart';
import 'price_indicator.dart';

class PriceItemMobile extends StatelessWidget {
  const PriceItemMobile({
    super.key,
    required this.priceModel,
  });

  final PriceModel priceModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return InkWell(
      onTap: () {
        String? symbol = priceModel.symbol;
        if (symbol != null) {
          context.pushNamed(
            'detail',
            queryParameters: {
              'symbol': symbol,
              'name': priceModel.name ?? '',
            },
          );
        }
      },
      child: Card(
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
                          '\$${NumberUtils.commaDecimal(priceModel.currentPrice ?? 0, 2)}'),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '1h',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '24h',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '7d',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        priceIndicator(
                            priceModel.priceChangePercentage1hInCurrency),
                        Text(
                          priceModel.priceChangePercentage1hInCurrency
                                  ?.abs()
                                  .toStringAsFixed(1) ??
                              '',
                          style: TextStyle(
                            color: indicatorColor(
                                priceModel.priceChangePercentage1hInCurrency),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        priceIndicator(
                            priceModel.priceChangePercentage24hInCurrency),
                        Text(
                          priceModel.priceChangePercentage24hInCurrency
                                  ?.abs()
                                  .toStringAsFixed(1) ??
                              '',
                          style: TextStyle(
                            color: indicatorColor(
                                priceModel.priceChangePercentage24hInCurrency),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          priceIndicator(
                              priceModel.priceChangePercentage7dInCurrency),
                          Text(
                            priceModel.priceChangePercentage7dInCurrency
                                    ?.abs()
                                    .toStringAsFixed(1) ??
                                '',
                            style: TextStyle(
                              color: indicatorColor(
                                  priceModel.priceChangePercentage7dInCurrency),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      '24 hr volume',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Market Cap',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      NumberUtils.commaValue(priceModel.totalVolume ?? 0),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        NumberUtils.commaValue(priceModel.marketCap ?? 0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
