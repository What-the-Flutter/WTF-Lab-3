import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

import '../../../../features/chat/chat.dart';
import '../../../models/ui/message.dart';
import '../../../utils/insets.dart';
import '../../../utils/locale.dart' as locale;
import '../../../utils/text_styles.dart';
import '../../theme/theme.dart';
import '../settings.dart';

part '../widget/chat_settings/center_chat_bubble_item.dart';

part '../widget/chat_settings/change_theme_item.dart';

part '../widget/chat_settings/message_alignment_item.dart';

part '../widget/chat_settings/manage_image_buttons.dart';

part '../widget/chat_settings/mock_message_list.dart';

class ChatSettingsPage extends StatelessWidget {
  const ChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.SettingsPage.chatItem.i18n(),
        ),
      ),
      body: Column(
        children: [
          const _MockMessageList(),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _ManageImageButton(),
                _ItemDivider(),
                _ChangeThemeItem(),
                _ItemDivider(),
                _MessageAlignmentItem(),
                _CenterChatBubbleItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemDivider extends StatelessWidget {
  const _ItemDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 10,
      color: Theme.of(context).colorScheme.background,
    );
  }
}
