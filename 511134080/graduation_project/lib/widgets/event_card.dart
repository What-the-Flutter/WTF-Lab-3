import 'package:flutter/material.dart';
import 'package:graduation_project/cubits/events_cubit.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          context.read<EventsCubit>().manageFavouriteEventCard(cardModel);
        } else {
          context.read<EventsCubit>().manageSelectedEvent(cardModel);
        }
      },
      onLongPress: () {
        if (!cardModel.isSelectionMode) {
          context.read<EventsCubit>().turnOnSelectionMode(cardModel);
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
                  ? Theme.of(context).primaryColor.withAlpha(99)
                  : Theme.of(context).primaryColor.withAlpha(72),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: _createEventCardContent(context),
          ),
        ],
      ),
    );
  }
}
