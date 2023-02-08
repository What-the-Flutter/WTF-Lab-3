import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../common/values/dimensions.dart';
import '../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../common/utils/strings.dart';
import '../../../../../data/repo/chat_repository.dart';
import '../../../../../domain/chat_model.dart';

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
