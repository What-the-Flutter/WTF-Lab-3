import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../utils/insets.dart';
import '../utils/radius.dart';

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  final result = await showCustomModalBottomSheet(
    context: context,
    builder: builder,
    useRootNavigator: true,
    expand: false,
    containerWidget: (_, animation, child) {
      return _FloatingModal(
        child: child,
      );
    },
  );

  return result;
}

class _FloatingModal extends StatelessWidget {
  const _FloatingModal({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(
          Insets.large,
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(
            Radius.large,
          ),
          child: child,
        ),
      ),
    );
  }
}
