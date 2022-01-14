import 'package:intl/intl.dart';

final NumberFormat monetaryFormat = NumberFormat('0.00', 'pl-PL');

String toMonetaryFormat(double value) {
  return '${monetaryFormat.format(value)} zł/kg';
}

String toMonetaryFormatAlt(double value) {
  return '${monetaryFormat.format(value)} zł';
}
