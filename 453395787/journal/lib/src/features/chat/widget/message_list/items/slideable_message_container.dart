import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableMessageContainer extends StatelessWidget {
  const SlidableMessageContainer({
    super.key,
    required this.child,
    required this.valueKey,
    required this.onEdit,
    required this.onDelete,
    required this.isEditMode,
  });

  final Widget child;
  final ValueKey<Object> valueKey;
  final void Function() onEdit;
  final void Function() onDelete;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: 0,
      key: valueKey,
      child: child,
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          dismissalDuration: const Duration(
            milliseconds: 50,
          ),
          onDismissed: onDelete,
        ),
        children: [
          SlidableAction(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            onPressed: (_) => onDelete(),
            icon: Icons.delete_outline,
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          dismissalDuration: const Duration(
            milliseconds: 50,
          ),
          confirmDismiss: () async {
            onEdit();
            return false;
          },
          closeOnCancel: true,
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            autoClose: false,
            backgroundColor: Colors.transparent,
            foregroundColor: !isEditMode
                ? Theme.of(context).colorScheme.onBackground
                : Colors.green,
            onPressed: (_) => onEdit(),
            icon: Icons.edit_outlined,
          )
        ],
      ),
    );
  }
}
