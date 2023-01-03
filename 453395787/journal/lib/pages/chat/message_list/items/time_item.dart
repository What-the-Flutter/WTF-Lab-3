import 'package:flutter/material.dart';

import '../../../../utils/insets.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.small,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Chip(
          label: Text(text),
          labelPadding: const EdgeInsets.symmetric(
            vertical: Insets.none,
            horizontal: Insets.large,
          ),
        ),
      ),
    );
  }
}
