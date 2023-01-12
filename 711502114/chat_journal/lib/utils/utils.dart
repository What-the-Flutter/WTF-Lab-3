import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String formatDate(BuildContext context, DateTime date,
    {bool includeTime = false}) {
  final local = AppLocalizations.of(context);

  if (local == null) return '';

  final year = date.year;
  final month = date.month;
  final day = date.day;

  final dateTimeNow = DateTime.now();
  final nowYear = dateTimeNow.year;

  if (year == nowYear && day == dateTimeNow.day) {
    return includeTime ? formatTime(date, includeSec: false) : local.today;
  } else if (year == nowYear) {
    return '${_getMonthName(local, month)} $day';
  } else {
    return '${_getMonthName(local, month)} $day, $year';
  }
}

String _getMonthName(AppLocalizations local, int month) => [
      local.jan,
      local.feb,
      local.mar,
      local.apr,
      local.may,
      local.june,
      local.july,
      local.aug,
      local.sep,
      local.oct,
      local.nov,
      local.dec,
    ][month];

String formatTime(DateTime time, {bool includeSec = true}) {
  final hours = time.hour;
  final hour = hours < 10 ? '0$hours' : '$hours';

  final minutes = time.minute;
  final min = minutes < 10 ? '0$minutes' : '$minutes';

  return '$hour:$min${_addSeconds(time.second, includeSec)}';
}

String _addSeconds(int seconds, bool include) {
  if (!include) return '';
  final sec = seconds < 10 ? '0$seconds' : '$seconds';
  return ':$sec';
}
