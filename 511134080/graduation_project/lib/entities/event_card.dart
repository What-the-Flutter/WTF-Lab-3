import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final String title;

  final DateTime time;

  final bool isFavourite;

  final bool isLongPress;

  const EventCard({
    required this.title,
    required this.time,
    this.isFavourite = false,
    this.isLongPress = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(80),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
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
                    color: isLongPress
                        ? Colors.black38
                        : Theme.of(context).primaryColor.withAlpha(0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('hh:mm a').format(time),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.bookmark,
                    size: 16,
                    color: isFavourite
                        ? Colors.black38
                        : Theme.of(context).primaryColor.withAlpha(0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
