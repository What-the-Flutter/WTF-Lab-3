import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../presentation/pages/settings/settings_cubit.dart';
import '../../theme/colors.dart';

String formatDate(BuildContext context, String date,
    {bool includeTime = false}) {
  final local = AppLocalizations.of(context);

  if (local == null) return '';

  final dateTime = DateTime.parse(date);

  final year = dateTime.year;
  final month = dateTime.month;
  final day = dateTime.day;

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

String formatTime(String time, {bool includeSec = true}) {
  final dateTime = DateTime.parse(time);

  final hours = dateTime.hour;
  final hour = hours < 10 ? '0$hours' : '$hours';

  final minutes = dateTime.minute;
  final min = minutes < 10 ? '0$minutes' : '$minutes';

  return '$hour:$min${_addSeconds(dateTime.second, includeSec)}';
}

String _addSeconds(int seconds, bool include) {
  if (!include) return '';
  final sec = seconds < 10 ? '0$seconds' : '$seconds';
  return ':$sec';
}

void openNewPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

void closePage(BuildContext context) {
  Navigator.pop(context);
}

bool checkOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait ||
      WidgetsBinding.instance.window.viewInsets.bottom <= 0.0;
}

String fitText(String text, int maxSymbols) {
  if (text.length <= maxSymbols) {
    return text;
  }

  return '${text.substring(0, maxSymbols - 1)}...';
}

int countOrientationCoefficient(BuildContext context) {
  final media = MediaQuery.of(context);

  if (media.orientation == Orientation.portrait) {
    return 1;
  } else {
    return media.size.width ~/ media.size.height;
  }
}

TextTheme textTheme(BuildContext context) {
  switch (context.read<SettingsCubit>().state.fontSize) {
    case 1:
      return CustomTheme.largeTextTheme;
    case -1:
      return CustomTheme.smallTextTheme;
    default:
      return CustomTheme.defaultTextTheme;
  }
}
