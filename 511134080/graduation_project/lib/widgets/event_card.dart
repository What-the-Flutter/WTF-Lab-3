import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/event.dart';
import '../pages/chat/chat_cubit.dart';

class EventCard extends StatelessWidget {
  final Event _cardModel;

  const EventCard({
    required Event cardModel,
    required Key key,
  })  : _cardModel = cardModel,
        super(key: key);

  Widget _createEventCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 240,
          ),
          child: _cardModel.title.isNotEmpty
              ? Text(
                  _cardModel.title,
                  style: const TextStyle(),
                )
              : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: _cardModel.imagePath != null
              ? Container(
                  constraints: const BoxConstraints(
                    maxWidth: 240,
                  ),
                  child: Image.network(
                    _cardModel.imagePath!,
                  ),
                )
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: _cardModel.isSelected
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(_cardModel.time),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.bookmark,
              size: 16,
              color: _cardModel.isFavourite
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
        context.read<ChatCubit>().manageTapEvent(_cardModel);
      },
      onLongPress: () {
        context.read<ChatCubit>().manageLongPress(_cardModel);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _cardModel.isSelected
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
                  child: _cardModel.categoryIndex != 0
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                categoryIcons[_cardModel.categoryIndex],
                                size: 32,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categoryTitle[_cardModel.categoryIndex],
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
