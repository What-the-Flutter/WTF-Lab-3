import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final DateTime date;

  const DateCard({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent.shade100,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Text(
            DateFormat('dd.MM.yyyy').format(date),
            style: const TextStyle(),
          ),
        ),
      ],
    );
  }
}
