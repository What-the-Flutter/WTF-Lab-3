import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String timeJmFormat() => DateFormat.jm().format(this);

  String dateYMMMDFormat() => DateFormat.yMMMd().format(this);
}