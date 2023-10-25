import 'package:intl/intl.dart';

class Utils {
  priceFormatWithSymbol(dynamic number) {
    return NumberFormat.currency(locale: "th_TH", symbol: "฿").format(number);
  }

  priceFormat(dynamic number) {
    return NumberFormat.currency(locale: "th_TH", symbol: "").format(number);
  }
}
