import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../common/values/dimensions.dart';
import '../../../../../data/repo/chat_repository.dart';
import '../../../../../domain/chat_model.dart';

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
            children: const [
              Icon(Icons.attach_file),
              SizedBox(width: Insets.appConstantSmall),
              Text('Pin/Unpin chat'),
            ],
          ),
        ),
      ),
    );
  }
}
