import 'package:flutter/material.dart';

import '../../../../../common/utils/extensions.dart';
import '../../../../../common/utils/insets.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.small,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Chip(
          label: Text(
            dateTime.formatMonthDay,
          ),
          labelPadding: const EdgeInsets.symmetric(
            vertical: Insets.none,
            horizontal: Insets.large,
          ),
        ),
      ),
    );
  }
}
