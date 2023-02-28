import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import 'timeline_message_card.dart';

class TimelineMessageListItem extends StatelessWidget {
  final MessageModel message;
  final int index;

  const TimelineMessageListItem({
    super.key,
    required this.message,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Align(
            alignment: Alignment.centerRight,
            child: TimelineMessageCard(
              message: message,
            ),
          ),
        ),
      ),
    );
  }
}
