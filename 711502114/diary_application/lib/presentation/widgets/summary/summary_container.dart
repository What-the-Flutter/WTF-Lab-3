import 'package:flutter/material.dart';

class SummaryContainer extends Container {
  final Color backgroundColor;
  final int count;
  final String category;

  SummaryContainer({
    required this.backgroundColor,
    required this.count,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text('$category: $count'),
        ],
      ),
    );
  }
}
