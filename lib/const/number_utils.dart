import 'package:intl/intl.dart';

class NumberUtils {
  static String commaDecimal(num value, int decimal) {
    final formatter = NumberFormat('#,##0.${'0' * decimal}');
    return formatter.format(value);
  }

  static String commaValue(num value) {
    return NumberFormat.decimalPattern().format(value);
  }
}
