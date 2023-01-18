import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/event.dart';
import '../../theme/colors.dart';
import '../../utils/utils.dart';

class EventBox extends StatelessWidget {
  final Event event;
  final Size size;
  final bool isSelected;

  EventBox({
    Key? key,
    required this.event,
    required this.size,
    required this.isSelected,
  }) : super(key: key);

  late final Image _image;

  final _iconFavoriteColor = Colors.yellow;
  final _iconNonFavoriteColor = Colors.transparent;
  final _circular = const Radius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!_isValidPath(event.photoPath))
            _messageContainer()
          else if (event.message.isEmpty)
            _attachContainer()
          else
            Column(
              children: [
                _messageContainer(size.width * .75, false),
                _attachContainer(false),
              ],
            ),
          const SizedBox(width: 10),
          Row(
            children: [
              Icon(
                Icons.bookmark,
                color: event.isFavorite
                    ? _iconFavoriteColor
                    : _iconNonFavoriteColor,
                size: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(formatDate(context, event.dateTime)),
                  Text(formatTime(event.dateTime)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messageContainer([double minWidth = 0.0, bool isUsualText = true]) {
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: size.width * .75,
      ),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? circleMessageSelectedColor : circleMessageColor,
        borderRadius: BorderRadius.only(
          topLeft: _circular,
          topRight: _circular,
          bottomRight: isUsualText ? _circular : Radius.zero,
        ),
      ),
      child: Text(
        event.message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget _attachContainer([bool isUsualAttach = true]) {
    return Container(
      constraints: BoxConstraints(minWidth: size.width * .75),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? circleMessageSelectedColor : circleMessageColor,
        borderRadius: BorderRadius.only(
          topLeft: isUsualAttach ? _circular : Radius.zero,
          topRight: isUsualAttach ? _circular : Radius.zero,
          bottomRight: _circular,
        ),
      ),
      child: SizedBox(
        child: _image,
        width: size.width * 0.3,
        height: size.height * 0.3,
      ),
    );
  }

  bool _isValidPath(String? path) {
    if (path == null || path.isEmpty) return false;

    try {
      _image = Image.file(File(path));
      return true;
    } catch (e) {
      return false;
    }
  }
}
