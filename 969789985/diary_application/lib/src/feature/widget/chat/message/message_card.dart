import 'package:flutter/material.dart';

import '../../../../core/data/repository/theme/theme_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/painter/triangle.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/strings.dart';
import '../../general/message/base_image_shower.dart';
import '../../general/message/base_message_content.dart';
import '../../theme/theme_scope.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomPaint(
                      foregroundPainter: Triangle(
                        ThemeScope.of(context).state.messageAlignment ==
                                BubbleAlignments.start.alignment
                            ? Color(
                                ThemeScope.of(context).state.primaryItemColor)
                            : Colors.transparent,
                      ),
                    ),
                    Flexible(
                      child: AnimatedAlign(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 500),
                        alignment: _messageAlignment(context),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: _maxWidth),
                          margin: const EdgeInsets.only(bottom: Insets.small),
                          child: Material(
                            borderRadius: _messageBorders(context),
                            color: Color(
                              ThemeScope.of(context).state.primaryItemColor,
                            ),
                            child: InkWell(
                              onTap: isExample ? null : pressedAction,
                              onLongPress: isExample ? null : longPressAction,
                              borderRadius: _messageBorders(context),
                              child: BaseMessageContent(
                                message: message,
                                fromChat: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _triangle(context, BubbleAlignments.end),
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
              BaseImageShower(
                message: message,
                fromChat: true,
              ),
            ],
          );
  }

  Widget _triangle(BuildContext context, BubbleAlignments alignment) {
    return ThemeScope.of(context).state.messageAlignment == alignment.alignment
        ? CustomPaint(
            foregroundPainter: Triangle(
              Color(ThemeScope.of(context).state.primaryItemColor),
            ),
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: Insets.none,
            height: Insets.none,
          );
  }

  Alignment _messageAlignment(BuildContext context) {
    final alignment = ThemeScope.of(context).state.messageAlignment;

    switch (alignment) {
      case MessageAlignment.start:
        return Alignment.centerLeft;
      case MessageAlignment.center:
        return Alignment.center;
      case MessageAlignment.end:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  BorderRadius _messageBorders(BuildContext context) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        ThemeScope.of(context).state.messageAlignment ==
                BubbleAlignments.start.alignment
            ? 0.0
            : ThemeScope.of(context).state.messageBorderRadius,
      ),
      bottomLeft: Radius.circular(
        ThemeScope.of(context).state.messageBorderRadius,
      ),
      bottomRight: Radius.circular(
        ThemeScope.of(context).state.messageBorderRadius,
      ),
      topRight: Radius.circular(
        ThemeScope.of(context).state.messageAlignment ==
                BubbleAlignments.end.alignment
            ? 0.0
            : ThemeScope.of(context).state.messageBorderRadius,
      ),
    );
  }
}
