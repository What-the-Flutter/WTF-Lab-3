import 'package:flutter/material.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/events_provider.dart';

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
            Consumer<EventsProvider>(
              builder: (context, _, __) => Icon(
                Icons.bookmark,
                size: 16,
                color: cardModel.isFavourite
                    ? Colors.black38
                    : Theme.of(context).primaryColor.withAlpha(0),
              ),
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
          Provider.of<EventsProvider>(context, listen: false)
              .manageFavouriteEventCard(cardModel);
        } else {
          print('selection mode');
          Provider.of<EventsProvider>(context, listen: false)
              .manageSelectedEvent(cardModel);
        }
      },
      onLongPress: () {
        print('Long press');
        if (!cardModel.isSelectionMode) {
          Provider.of<EventsProvider>(context, listen: false)
              .turnOnSelectionMode(cardModel);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<EventsProvider>(
            builder: (context, _, __) => Container(
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
          ),
        ],
      ),
    );
  }
}
