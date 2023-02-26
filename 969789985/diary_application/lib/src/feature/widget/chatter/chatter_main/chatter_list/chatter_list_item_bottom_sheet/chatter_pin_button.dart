import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../../../core/data/repository/chat/chat_repository.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';

class ChatterPinButton extends StatelessWidget {
  final ChatModel chat;

  const ChatterPinButton({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        onPressed: () {
          RepositoryProvider.of<ChatRepository>(context).update(
            chat.copyWith(isPinned: !chat.isPinned),
          );
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.medium),
          child: Row(
            children: [
              const Icon(Icons.attach_file),
              const SizedBox(width: Insets.appConstantSmall),
              Text(chat.isPinned ? 'Unpin chat' : 'Pin chat'),
            ],
          ),
        ),
      ),
    );
  }
}
