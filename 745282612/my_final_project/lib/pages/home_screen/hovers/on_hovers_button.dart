import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  const HoverButton({super.key, required this.child});
  final Widget child;
  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;
  void onEntered(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }

  final hoverTransf = Matrix4.identity()..scale(1.1);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered ? hoverTransf : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}
