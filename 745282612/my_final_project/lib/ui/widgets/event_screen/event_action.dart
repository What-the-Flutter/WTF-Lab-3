import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_message.dart';

class EventAction extends StatefulWidget {
  final Event event;
  final bool isSelected;

  const EventAction({
    super.key,
    required this.event,
    required this.isSelected,
  });

  @override
  State<EventAction> createState() => _EventActionState();
}

class _EventActionState extends State<EventAction> {
  void isDismissibleAction(DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      context.read<EventCubit>().deleteEvent(widget.event);
      final snackBar = SnackBar(
        content: Text(S.of(context).delete_element),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (direction == DismissDirection.startToEnd) {
      context.read<EventCubit>().changeSelectedItem(widget.event.id);
      context.read<EventCubit>().changeSelected();
      context.read<EventCubit>().changeEditText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: const Icon(Icons.edit),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: const Icon(Icons.delete),
      ),
      key: UniqueKey(),
      onDismissed: isDismissibleAction,
      child: GestureDetector(
        onLongPress: () {
          if (!widget.isSelected) {
            context.read<EventCubit>().changeSelectedItem(widget.event.id);
            context.read<EventCubit>().changeSelected();
          }
        },
        onTap: () {
          if (widget.isSelected) {
            context.read<EventCubit>().changeSelectedItem(widget.event.id);
          }
        },
        child: EventMessage(event: widget.event),
      ),
    );
  }
}
