import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../pages/chat/chat_cubit.dart';

class EventCard extends StatelessWidget {
  final EventCardModel cardModel;

  const EventCard({
    required this.cardModel,
    required Key key,
  }) : super(key: key);

  Widget _createEventCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cardModel.title,
          style: const TextStyle(),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: cardModel.isSelected
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(cardModel.time),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.bookmark,
              size: 16,
              color: cardModel.isFavourite
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!cardModel.isSelectionMode) {
          context.read<ChatCubit>().manageFavouriteEventCard(cardModel);
        } else {
          context.read<ChatCubit>().manageSelectedEvent(cardModel);
        }
      },
      onLongPress: () {
        if (!cardModel.isSelectionMode) {
          context.read<ChatCubit>().turnOnSelectionMode(cardModel);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardModel.isSelected
                  ? Theme.of(context).focusColor
                  : Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: cardModel.categoryIndex != null
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                categoryIcons[cardModel.categoryIndex!],
                                size: 32,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categoryTitle[cardModel.categoryIndex!],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
                _createEventCardContent(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
