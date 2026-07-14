import 'package:intl/intl.dart';

String getDatetimeHeader(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final orderDate = DateTime(date.year, date.month, date.day);
  if (orderDate == today) {
    return 'Today';
  }
  if (orderDate == yesterday) {
    return 'Yesteday';
  } else {
    return DateFormat.yMMMEd().format(date);
  }
}
