import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../general/custom_dialog.dart';
import '../../../../../../core/util/resources/strings.dart';
import '../../../../../../core/data/repository/chat/chat_repository.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';

class ChatterDeleteButton extends StatelessWidget {
  final ChatModel chat;

  const ChatterDeleteButton({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => CustomDialog(
            dialogTitle: Strings.deleteChatTitle,
            dialogDescription: const Text(Strings.deleteChatDescription),
            completeAction: () {
              RepositoryProvider.of<ChatRepository>(context).remove(chat);
              Navigator.pop(context);
            },
            cancelVisible: true,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.medium),
          child: Row(
            children: const [
              Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              SizedBox(width: Insets.appConstantSmall),
              Text(
                'Delete chat',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
