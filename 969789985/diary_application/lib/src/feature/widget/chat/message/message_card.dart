import 'package:flutter/material.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/painter/triangle.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../theme/theme_scope.dart';
import 'image_shower.dart';
import 'message_content.dart';
import 'message_selection_checkbox.dart';

class MessageCard extends StatelessWidget {
  final MessageModel message;
  final Function() pressedAction;
  final Function() longPressAction;
  final bool isExample;

  MessageCard({
    super.key,
    required this.message,
    required this.pressedAction,
    required this.longPressAction,
    required this.isExample,
  });

  final double _maxWidth = 350.0;

  @override
  Widget build(BuildContext context) {
    return message.images.isEmpty
        ? Row(
            children: [
              isExample
                  ? Container(width: Insets.none, height: Insets.none)
                  : MessageSelectionCheckbox(message: message),
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
                          color: Color(
                            ThemeScope.of(context).state.primaryItemColor,
                          ),
                          child: InkWell(
                            onTap: isExample ? null : pressedAction,
                            onLongPress: isExample ? null : longPressAction,
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
                      foregroundPainter: Triangle(
                        Color(ThemeScope.of(context).state.primaryItemColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              isExample
                  ? Container(width: Insets.none, height: Insets.none)
                  : MessageSelectionCheckbox(message: message),
              const Spacer(),
              ImageShower(message: message),
            ],
          );
  }
}
