import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String timeJmFormat() => DateFormat.jm().format(this);

  String dateYMMMDFormat() => DateFormat.yMMMd().format(this);

  String dayOfWeekend() {
    return day == DateTime.now().day
        ? 'Today'
        : DateFormat('EEEE').format(this).substring(0, 3);
  }
}
