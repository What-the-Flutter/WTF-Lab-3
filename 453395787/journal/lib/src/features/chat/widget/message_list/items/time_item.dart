import 'package:flutter/material.dart';

import '../../../../../common/extensions/date_time_extensions.dart';
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
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black45,
          ),
          child: Chip(
            label: Text(
              dateTime.formatMonthDay,
              style: DefaultTextStyle.of(context).style.copyWith(
                    color: Colors.white,
                  ),
            ),
            labelPadding: const EdgeInsets.symmetric(
              vertical: Insets.none,
              horizontal: Insets.large,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
