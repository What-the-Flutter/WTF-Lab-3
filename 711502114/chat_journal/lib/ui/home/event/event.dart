import 'dart:io';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../utils/utils.dart';
import 'message_data.dart';

enum MessageType { text, attach, textWithAttach }

class Event extends StatefulWidget {
  final MessageData messageData;
  final Size size;

  Event({Key? key, required this.messageData, required this.size})
      : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
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
          if (!_isValidPath(widget.messageData.photoPath))
            _buildMessageBox(MessageType.text)
          else if (widget.messageData.message.isEmpty)
            _buildMessageBox(MessageType.attach)
          else
            _buildMessageBox(MessageType.textWithAttach),
          const SizedBox(width: 10),
          Row(
            children: [
              Icon(
                Icons.bookmark,
                color: widget.messageData.isFavorite
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
                  Text(formatDate(context, widget.messageData.dateTime)),
                  Text(formatTime(widget.messageData.dateTime)),
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
            maxWidth: widget.size.width * .75,
          );
          borderRadius = BorderRadius.only(
            topLeft: circular,
            topRight: circular,
            bottomRight: circular,
          );
        }

        child = Text(
          widget.messageData.message,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.clip,
        );
        break;
      case MessageType.attach:
        if (constraints == null && radius == null) {
          boxConstraints = BoxConstraints(
            minWidth: widget.size.width * .75,
          );
          borderRadius = BorderRadius.only(
            topLeft: circular,
            topRight: circular,
            bottomRight: circular,
          );
        }

        child = SizedBox(
          child: _image,
          width: widget.size.width * 0.3,
          height: widget.size.height * 0.3,
        );
        break;
      case MessageType.textWithAttach:
        return Column(
          children: [
            _buildMessageBox(
              MessageType.text,
              constraints: BoxConstraints(
                minWidth: widget.size.width * .75,
                maxWidth: widget.size.width * .75,
              ),
              radius: BorderRadius.only(
                topLeft: circular,
                topRight: circular,
              ),
            ),
            _buildMessageBox(
              MessageType.attach,
              constraints: BoxConstraints(
                minWidth: widget.size.width * .75,
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
        color: circleMessageColor,
        borderRadius: borderRadius,
      ),
      child: GestureDetector(
        child: child,
        onLongPress: () {
          setState(() {
            widget.messageData.isFavorite = !widget.messageData.isFavorite;
          });
        },
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
