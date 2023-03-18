import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String timeJmFormat() => DateFormat.jm().format(this);

  String dateYMMMDFormat() => DateFormat.yMMMd().format(this);

  String dayOfWeekend() {
    final now = DateTime.now();

    if(day == now.day) {
      return 'Today';
    }

    return DateFormat('EEEE').format(this).substring(0, 3);
  }
}