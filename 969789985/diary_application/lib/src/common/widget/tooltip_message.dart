import 'package:flutter/material.dart';

import '../values/dimensions.dart';

class TooltipMessage extends StatelessWidget {
  final String message;
  final GlobalKey tooltipKey;
  final Widget childWidget;

  const TooltipMessage({
    super.key,
    required this.message,
    required this.tooltipKey,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) => Tooltip(
        key: tooltipKey,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        padding: const EdgeInsets.all(Insets.appConstantMedium),
        textStyle: const TextStyle(color: Colors.black),
        triggerMode: TooltipTriggerMode.manual,
        showDuration: const Duration(seconds: 20),
        waitDuration: const Duration(seconds: 1),
        message: message,
        child: childWidget,
      );
}
