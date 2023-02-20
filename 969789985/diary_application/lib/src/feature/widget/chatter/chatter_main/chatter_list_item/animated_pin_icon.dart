import 'package:flutter/material.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';

class AnimatedPinIcon extends StatelessWidget {
  final ChatModel chat;

  const AnimatedPinIcon({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: chat.isPinned ? 1.0 : 0.0,
      child: const Icon(Icons.attach_file),
    );
  }
}
