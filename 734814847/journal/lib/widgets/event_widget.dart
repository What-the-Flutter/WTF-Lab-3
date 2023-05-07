import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  final String text;
  final IconData? icon;
  final DateTime date;

  Event({required this.text, required this.date, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Text(text),
        ),
      ],
    );
  }
}
