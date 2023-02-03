import 'package:flutter/material.dart';

import '../../../../../common/painter/triangle.dart';
import '../../../../../common/values/dimensions.dart';
import '../../../domain/message_model.dart';
import 'image_shower.dart';
import 'message_checkbox.dart';
import 'message_content.dart';

class MessageCard extends StatelessWidget {
  final MessageModel message;
  final Function() pressedAction;
  final Function() longPressAction;

  MessageCard({
    super.key,
    required this.message,
    required this.pressedAction,
    required this.longPressAction,
  });

  final double _maxWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return message.images.isEmpty
        ? Row(
            children: [
              MessageCheckbox(message: message),
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
                            topLeft: Radius.circular(
                              Radii.appConstantExtraLarge,
                            ),
                            bottomLeft: Radius.circular(
                              Radii.appConstantExtraLarge,
                            ),
                            bottomRight: Radius.circular(
                              Radii.appConstantExtraLarge,
                            ),
                          ),
                          color: Theme.of(context).cardTheme.color,
                          child: InkWell(
                            onTap: pressedAction,
                            onLongPress: longPressAction,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                Radii.appConstantExtraLarge,
                              ),
                              bottomLeft: Radius.circular(
                                Radii.appConstantExtraLarge,
                              ),
                              bottomRight: Radius.circular(
                                Radii.appConstantExtraLarge,
                              ),
                            ),
                            child: MessageContent(message: message),
                          ),
                        ),
                      ),
                    ),
                    CustomPaint(
                      foregroundPainter:
                          Triangle(Theme.of(context).cardTheme.color!),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              MessageCheckbox(message: message),
              const Spacer(),
              ImageShower(message: message),
            ],
          );
  }
}
