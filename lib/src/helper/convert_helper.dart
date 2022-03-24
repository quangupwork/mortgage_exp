import 'package:intl/intl.dart';

class ConvertHelper {
  static String formartNumber(String text) {
    double number = double.parse(text);
    final result = NumberFormat.decimalPattern().format(number);
    return result;
  }
}
