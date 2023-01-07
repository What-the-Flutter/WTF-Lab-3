import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String format(String pattern) => DateFormat(pattern).format(this);

  String get formatMonthDay => format('MMM d');

  String get formatTime => DateFormat.jm().format(this);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
