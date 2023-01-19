import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeJmFormat() => DateFormat.jm().format(this);

  String dateYMMMDFormat() => DateFormat.yMMMd().format(this);
}

extension StringExtension on String {
  String excludeEmptyLines() {
    return split(RegExp(r'(?:\r?\n|\r)'))
        .where((s) => s.trim().isNotEmpty)
        .join('\n');
  }
}
