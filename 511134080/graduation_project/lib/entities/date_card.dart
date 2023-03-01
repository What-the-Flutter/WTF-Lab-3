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
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent.shade100,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            DateFormat('dd.MM.yyyy').format(date),
            style: TextStyle(),
          ),
        ),
      ],
    );
  }
}
