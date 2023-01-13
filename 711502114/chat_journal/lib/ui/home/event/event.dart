import 'dart:io';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../utils/utils.dart';
import 'message_data.dart';

enum MessageType { text, attach, textWithAttach }

class Event extends StatelessWidget {
  final MessageData messageData;
  final Size size;
  final bool isSelected;

  Event({
    Key? key,
    required this.messageData,
    required this.size,
    required this.isSelected,
  }) : super(key: key);

  late final Image _image;

  final _iconFavoriteColor = Colors.yellow;
  final _iconNonFavoriteColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!_isValidPath(messageData.photoPath))
            _buildMessageBox(MessageType.text)
          else if (messageData.message.isEmpty)
            _buildMessageBox(MessageType.attach)
          else
            _buildMessageBox(MessageType.textWithAttach),
          const SizedBox(width: 10),
          Row(
            children: [
              Icon(
                Icons.bookmark,
                color: messageData.isFavorite
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
                  Text(formatDate(context, messageData.dateTime)),
                  Text(formatTime(messageData.dateTime)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBox(MessageType type,
      {BoxConstraints? constraints, BorderRadius? radius}) {
    var boxConstraints = constraints;
    var borderRadius = radius;
    Widget? child;

    final circular = const Radius.circular(25);

    switch (type) {
      case MessageType.text:
        if (constraints == null && radius == null) {
          boxConstraints = BoxConstraints(
            maxWidth: size.width * .75,
          );
          borderRadius = BorderRadius.only(
            topLeft: circular,
            topRight: circular,
            bottomRight: circular,
          );
        }

        child = Text(
          messageData.message,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.clip,
        );
        break;
      case MessageType.attach:
        if (constraints == null && radius == null) {
          boxConstraints = BoxConstraints(
            minWidth: size.width * .75,
          );
          borderRadius = BorderRadius.only(
            topLeft: circular,
            topRight: circular,
            bottomRight: circular,
          );
        }

        child = SizedBox(
          child: _image,
          width: size.width * 0.3,
          height: size.height * 0.3,
        );
        break;
      case MessageType.textWithAttach:
        return Column(
          children: [
            _buildMessageBox(
              MessageType.text,
              constraints: BoxConstraints(
                minWidth: size.width * .75,
                maxWidth: size.width * .75,
              ),
              radius: BorderRadius.only(
                topLeft: circular,
                topRight: circular,
              ),
            ),
            _buildMessageBox(
              MessageType.attach,
              constraints: BoxConstraints(
                minWidth: size.width * .75,
              ),
              radius: BorderRadius.only(
                bottomRight: circular,
              ),
            ),
          ],
        );
    }

    return Container(
      constraints: boxConstraints,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? circleMessageSelectedColor : circleMessageColor,
        borderRadius: borderRadius,
      ),
      child: child,
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
