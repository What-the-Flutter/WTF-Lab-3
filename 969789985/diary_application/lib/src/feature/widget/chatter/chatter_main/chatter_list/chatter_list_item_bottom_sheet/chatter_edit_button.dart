import 'package:flutter/material.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../page/chatter/chatter_edit_page.dart';

class ChatterEditButton extends StatelessWidget {
  final ChatModel chat;

  const ChatterEditButton({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        onPressed: () => _navigateToEditPage(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.medium),
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: Insets.appConstantSmall),
              Text('Edit chat'),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditChatScreen(chat: chat),
        ),
      );
}
