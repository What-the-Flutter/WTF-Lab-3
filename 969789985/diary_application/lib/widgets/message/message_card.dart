import 'package:flutter/material.dart';

import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../painter/triangle.dart';
import '../../ui/utils/dimensions.dart';
import 'image_shower.dart';

class MessageCard extends StatelessWidget {
  final ChatProvider provider;
  final MessageModel message;
  final Widget selectionCheckBox;
  final Function() pressedAction;
  final Function() longPressAction;

  MessageCard({
    super.key,
    required this.provider,
    required this.message,
    required this.selectionCheckBox,
    required this.pressedAction,
    required this.longPressAction,
  });

  final double _maxWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  margin: const EdgeInsets.only(bottom: Insets.small),
                  child: Material(
                    borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Radii.applicationConstantExtraLarge),
                      bottomLeft:
                          Radius.circular(Radii.applicationConstantExtraLarge),
                      bottomRight:
                          Radius.circular(Radii.applicationConstantExtraLarge),
                    ),
                    color: Theme.of(context).cardTheme.color,
                    child: InkWell(
                      onTap: pressedAction,
                      onLongPress: longPressAction,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                            Radii.applicationConstantExtraLarge),
                        bottomLeft: Radius.circular(
                            Radii.applicationConstantExtraLarge),
                        bottomRight: Radius.circular(
                            Radii.applicationConstantExtraLarge),
                      ),
                      child: _messageContent(),
                    ),
                  ),
                ),
              ),
              CustomPaint(
                foregroundPainter: Triangle(
                  Theme.of(context).cardTheme.color!,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _messageContent() {
    return Container(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
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
    );
  }

}
