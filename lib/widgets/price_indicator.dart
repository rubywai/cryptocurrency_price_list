import 'package:flutter/material.dart';

import '../const/indicator_color.dart';

Widget priceIndicator(num? value) {
  return (value ?? 0) > 0
      ? Icon(
          Icons.arrow_drop_up_sharp,
          color: indicatorColor(value!),
        )
      : Icon(
          Icons.arrow_drop_down_sharp,
          color: indicatorColor(value ?? 0.0),
        );
}
