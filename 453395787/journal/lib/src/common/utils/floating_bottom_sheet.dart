import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'insets.dart';
import 'radius.dart';

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
    context: context,
    builder: builder,
    useRootNavigator: true,
    containerWidget: (_, animation, child) {
      return _FloatingModal(
        child: child,
      );
    },
    expand: false,
  );

  return result;
}

class _FloatingModal extends StatelessWidget {
  const _FloatingModal({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(Radius.large),
          child: child,
        ),
      ),
    );
  }
}
