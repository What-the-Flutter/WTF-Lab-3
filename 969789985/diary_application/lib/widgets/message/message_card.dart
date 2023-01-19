import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../painter/triangle.dart';
import 'image_shower.dart';

class MessageCard extends StatelessWidget {
  MessageCard({
    super.key,
    required this.provider,
    required this.message,
    required this.selectionCheckBox,
    required this.longPressAction,
    required this.pressedAction,
  });

  final ChatProvider provider;
  final MessageModel message;
  final Widget selectionCheckBox;
  final Function() pressedAction;
  final Function() longPressAction;

  final double _maxWidth = 300.0;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          selectionCheckBox,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: _maxWidth),
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Material(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35.0),
                        bottomLeft: Radius.circular(35.0),
                        bottomRight: Radius.circular(35.0),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      child: InkWell(
                        onTap: pressedAction,
                        onLongPress: longPressAction,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                child: message.messageText.length < 27
                                    ? Column(
                                        children: [
                                          Text(
                                            '${message.messageText}   '
                                            '${message.sendDate.timeJmFormat()}',
                                          ),
                                          ImageShower(message: message),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(message.messageText),
                                          ImageShower(message: message),
                                          Text(
                                            message.sendDate.timeJmFormat(),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  foregroundPainter:
                      Triangle(Theme.of(context).primaryColorLight),
                ),
              ],
            ),
          ),
        ],
      );
}
