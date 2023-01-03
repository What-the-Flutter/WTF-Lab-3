import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../utils/confirmation_dialog.dart';
import '../chat_provider.dart';

part 'app_bar_with_actions.dart';
part 'app_bar_with_cancel.dart';
part 'default_app_bar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        if (chat.isEditMode) {
          return _AppBarWithCancelButton(
            chat: chat,
          );
        } else if (chat.hasSelected) {
          return _AppBarWithActions(
            chat: chat,
          );
        } else {
          return _DefaultAppBar(
            chat: chat,
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
