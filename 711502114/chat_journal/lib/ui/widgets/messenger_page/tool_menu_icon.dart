import 'package:flutter/material.dart';

class ToolMenuIcon extends StatelessWidget {
  final IconData icon;
  final double horizontal;
  final Color? color;
  final void Function()? onPressed;

  const ToolMenuIcon({
    Key? key,
    required this.icon,
    this.horizontal = 6.0,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontal),
      child: IconButton(
        icon: Icon(icon, size: 24, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
