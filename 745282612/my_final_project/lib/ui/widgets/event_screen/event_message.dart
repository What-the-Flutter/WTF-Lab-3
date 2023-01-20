import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';

class EventMessage extends StatefulWidget {
  final Event event;
  final bool isSelected;

  const EventMessage({
    super.key,
    required this.event,
    required this.isSelected,
  });

  @override
  State<EventMessage> createState() => _EventMessageState();
}

class _EventMessageState extends State<EventMessage> {
  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeCubit>().isLight();

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
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<EventCubit>().deleteEvent(widget.event);
          final snackBar = const SnackBar(
            content: Text('Delete element!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (direction == DismissDirection.startToEnd) {
          context.read<EventCubit>().changeSelectedItem(widget.event.id);
          context.read<EventCubit>().changeSelected();
          context.read<EventCubit>().changeEditText();
        }
      },
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          alignment:
              (widget.event.messageType == 'sender' ? Alignment.bottomLeft : Alignment.bottomRight),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2.5,
              minWidth: 100,
              minHeight: 80,
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isLight
                  ? widget.event.isSelected
                      ? Colors.blue
                      : AppColors.colorLisgtTurquoise
                  : widget.event.isSelected
                      ? Colors.grey.shade400
                      : Colors.grey.shade700,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 3),
                widget.event.sectionIcon != null
                    ? Row(
                        children: [
                          Icon(widget.event.sectionIcon),
                          Text(
                            widget.event.sectionTitle!,
                            style: TextStyle(
                              fontSize:
                                  context.watch<ThemeCubit>().state.textTheme.bodyText1!.fontSize,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 3),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: widget.event.messageImage != null
                      ? Image.network(widget.event.messageImage!)
                      : Text(
                          widget.event.messageContent,
                          style: TextStyle(
                            fontSize:
                                context.watch<ThemeCubit>().state.textTheme.bodyText1!.fontSize,
                          ),
                        ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('hh:mm a').format(widget.event.messageTime),
                        style: TextStyle(
                          color: AppColors.colorNormalGrey,
                          fontSize: context.watch<ThemeCubit>().state.textTheme.bodyText2!.fontSize,
                        ),
                      ),
                    ),
                    if (widget.event.isFavorit)
                      const Icon(
                        Icons.turned_in,
                        size: 15,
                        color: Colors.yellow,
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
