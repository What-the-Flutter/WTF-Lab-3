import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Event extends StatelessWidget {
  final String message;

  const Event({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message),
      decoration: BoxDecoration(
        color: circleMessageColor,
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
