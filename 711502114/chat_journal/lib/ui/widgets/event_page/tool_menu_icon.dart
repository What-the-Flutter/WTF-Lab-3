import 'package:flutter/material.dart';

class ToolMenuIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final void Function()? onPressed;

  const ToolMenuIcon({
    Key? key,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: IconButton(
        icon: Icon(icon, size: 24, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
