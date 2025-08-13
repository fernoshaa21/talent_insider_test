import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final formatter = NumberFormat('#,##0', 'en_US');
  return formatter.format(amount);
}
