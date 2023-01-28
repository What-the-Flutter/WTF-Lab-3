import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../utils/locale.dart' as locale;
import '../../../utils/text_styles.dart';
import '../../theme/theme.dart';
import '../cubit/settings_cubit.dart';
import '../data/settings_repository_api.dart';
import '../widget/manage_image_buttons.dart';
import '../widget/mock_message_list.dart';

part '../widget/center_chat_bubble_item.dart';
part '../widget/change_theme_item.dart';
part '../widget/message_alignment_item.dart';

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
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MockMessageList(),
            const ManageImageButtons(),
            const _ItemDivider(),
            const _ChangeThemeItem(),
            const _ItemDivider(),
            const _MessageAlignmentItem(),
            const _CenterChatBubbleItem(),
          ],
        ),
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
