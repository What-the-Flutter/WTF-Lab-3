import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../entities/message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../screens/travel_screen.dart';
import 'travel_day_screen.dart';

class TravelScreenListMessage extends StatelessWidget {
  const TravelScreenListMessage({
    super.key,
    required this.listMessage,
    required this.isSelected,
    required this.onSelected,
  });
  final List<Message> listMessage;
  final bool isSelected;
  final Function onSelected;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      reverse: true,
      itemCount: listMessage.length,
      itemBuilder: (context, index) {
        final indexMessage = listMessage[index];
        if (indexMessage.isDay) {
          return TravelDayScreen(content: indexMessage.messageContent);
        }
        return GestureDetector(
          onLongPress: () {
            if (!isSelected) {
              onSelected(indexMessage);
              TravelScreen.of(context).isSelected();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            alignment: (indexMessage.messageType == 'sender'
                ? Alignment.bottomLeft
                : Alignment.bottomRight),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
                minWidth: 100,
                minHeight: 80,
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: indexMessage.isSelected
                    ? Colors.grey.shade400
                    : (indexMessage.messageType == 'sender'
                        ? AppColors.colorLisgtTurquoise
                        : Colors.blue[200]),
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
                            color: AppColors.colorLightGrey,
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
