import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class TravelScreenListMessage extends StatelessWidget {
  final List<Event> listMessage;
  final bool isSelected;
  final Function onSelected;

  const TravelScreenListMessage({
    super.key,
    required this.listMessage,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      reverse: true,
      itemCount: listMessage.length,
      itemBuilder: (context, index) {
        final indexMessage = listMessage[index];
        return GestureDetector(
          onLongPress: () {
            if (!isSelected) {
              onSelected(index);
              TravelScreen.of(context).isSelected();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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
        );
      },
    );
  }
}
