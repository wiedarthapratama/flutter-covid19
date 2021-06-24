import 'package:intl/intl.dart';

myNumberFormat(param) {
  // final formatter = NumberFormat("#,###,###,###,###");
  final formatter = NumberFormat("###,###,###,###,###,###", "en_US");
  return formatter.format(param);
}
