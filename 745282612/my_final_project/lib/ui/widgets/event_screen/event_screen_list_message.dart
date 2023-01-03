import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventScreenListMessage extends StatelessWidget {
  final List<Event> listMessage;
  final bool isSelected;
  final bool isSearch;

  const EventScreenListMessage({
    super.key,
    required this.listMessage,
    required this.isSelected,
    required this.isSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: isSearch ? 10 : 70),
          reverse: true,
          itemCount: listMessage.length,
          itemBuilder: (context, index) {
            final indexMessage = listMessage[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  context.read<EventCubit>().deleteEvent(index);
                  final snackBar = const SnackBar(
                    content: Text('Delete element!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (direction == DismissDirection.startToEnd) {
                  context.read<EventCubit>().changeSelectedItem(index);
                  context.read<EventCubit>().changeSelected();
                  context.read<EventCubit>().changeCountSelected();
                  context.read<EventCubit>().changeEditText();
                }
              },
              child: GestureDetector(
                onLongPress: () {
                  if (!isSelected) {
                    context.read<EventCubit>().changeSelectedItem(index);
                    context.read<EventCubit>().changeSelected();
                    context.read<EventCubit>().changeCountSelected();
                  }
                },
                onTap: () {
                  if (isSelected) {
                    context.read<EventCubit>().changeSelectedItem(index);
                    context.read<EventCubit>().changeCountSelected();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  alignment: (indexMessage.messageType == 'sender'
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.5,
                      minWidth: 100,
                      minHeight: 80,
                      maxHeight: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme
                          ? indexMessage.isSelected
                              ? Colors.blue
                              : AppColors.colorLisgtTurquoise
                          : indexMessage.isSelected
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: indexMessage.messageImage ??
                              Text(
                                indexMessage.messageContent,
                                style: const TextStyle(fontSize: 16),
                              ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('hh:mm a')
                                    .format(indexMessage.messageTime),
                                style: const TextStyle(
                                  color: AppColors.colorNormalGrey,
                                ),
                              ),
                            ),
                            if (indexMessage.isFavorit)
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
          },
        );
      },
    );
  }
}
