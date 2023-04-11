import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    Key? key,
    required this.child,
    required this.title,
    required this.count,
  }) : super(key: key);

  final IconData child;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Text(title),
            Container(
              constraints: const BoxConstraints(
                minHeight: 65,
                minWidth: 65,
              ),
              decoration: BoxDecoration(
                color: addChatColor,
                shape: BoxShape.circle,
              ),
              child: Icon(child),
            ),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 10,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: circleMessageColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Text('$count', style: const TextStyle(fontSize: 24)),
          ),
        )
      ],
    );
  }
}
