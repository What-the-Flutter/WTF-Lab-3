import 'package:flutter/material.dart';

class DismissItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double xDirection;

  const DismissItem({
    Key? key,
    required this.color,
    required this.icon,
    required this.xDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Align(
        alignment: Alignment(xDirection, 0),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
