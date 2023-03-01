import 'package:flutter/material.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/events_provider.dart';

class EventCard extends StatelessWidget {
  final cardModel;

  EventCard({
    required String title,
    required DateTime time,
    bool isFavourite = false,
    bool isLongPress = false,
    required Key key,
  })  : cardModel = EventCardModel(
          title: title,
          time: time,
          id: key,
          isFavourite: isFavourite,
          isLongPress: isLongPress,
        ),
        super(key: key);

  Widget _createEventCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cardModel.title,
          style: TextStyle(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: cardModel.isLongPress
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(cardModel.time),
            ),
            SizedBox(
              width: 5,
            ),
            Consumer<EventsProvider>(
              builder: (context, provider, child) => Icon(
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
              .manageFavouriteEventCard(this);
        } else {
          Provider.of<EventsProvider>(context, listen: false)
              .manageSelectedEvent(this);
        }
      },
      onLongPress: () {
        if (!cardModel.isSelectionMode) {
          Provider.of<EventsProvider>(context, listen: false)
              .turnOnSelectionMode(this);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<EventsProvider>(
            builder: (context, provider, child) => Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cardModel.isLongPress
                    ? Theme.of(context).primaryColor.withAlpha(99)
                    : Theme.of(context).primaryColor.withAlpha(72),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
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
