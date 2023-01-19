import 'package:flutter/material.dart';

class TooltipMessage extends StatelessWidget {
  const TooltipMessage({
    super.key,
    required this.message,
    required this.tooltipKey,
    required this.childWidget,
  });

  final String message;
  final GlobalKey tooltipKey;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) => Tooltip(
        key: tooltipKey,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.all(15.0),
        textStyle: const TextStyle(color: Colors.black),
        triggerMode: TooltipTriggerMode.manual,
        showDuration: const Duration(seconds: 20),
        waitDuration: const Duration(seconds: 1),
        message: message,
        child: childWidget,
      );
}
