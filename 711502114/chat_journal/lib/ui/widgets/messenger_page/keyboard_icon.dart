import 'package:flutter/material.dart';

class KeyBoardIcon extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const KeyBoardIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(icon, size: 24),
      onPressed: onPressed,
    );
  }
}
