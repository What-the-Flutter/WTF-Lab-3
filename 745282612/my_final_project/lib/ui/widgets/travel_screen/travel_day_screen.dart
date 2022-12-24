import 'package:flutter/material.dart';

class TravelDayScreen extends StatelessWidget {
  const TravelDayScreen({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      alignment: Alignment.bottomLeft,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(
          maxWidth: 100,
          minWidth: 100,
          minHeight: 40,
          maxHeight: 40,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            color: Colors.pink),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
