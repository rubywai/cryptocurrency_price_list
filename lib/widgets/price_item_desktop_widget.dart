import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/indicator_color.dart';
import '../const/number_utils.dart';
import 'price_indicator.dart';

class PriceItemDesktopWidget extends StatelessWidget {
  const PriceItemDesktopWidget({super.key, required this.priceModel});
  final PriceModel priceModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 8.0),
          width: 200,
          height: 50,
          child: InkWell(
            onTap: () {
              context.pushNamed(
                'detail',
                queryParameters: {
                  'symbol': priceModel.symbol ?? '',
                  'name': priceModel.name ?? '',
                },
              );
            },
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
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 100,
          child: Text(
            priceModel.symbol?.toUpperCase() ?? '',
            style: textTheme.bodyLarge,
          ),
        ),
        Container(
          height: 50,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 150,
          child: Text(
              '\$${NumberUtils.commaDecimal(priceModel.currentPrice ?? 0, 2)}'),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 100,
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage1hInCurrency),
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
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 150,
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage24hInCurrency),
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
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 150,
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage7dInCurrency),
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
        Container(
          height: 50,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          width: 200,
          child: Text(
            NumberUtils.commaValue(priceModel.totalVolume ?? 0),
          ),
        ),
        Container(
          height: 50,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(right: 8.0),
          width: 200,
          child: Text(
            NumberUtils.commaValue(priceModel.marketCap ?? 0),
          ),
        ),
      ],
    );
  }
}
