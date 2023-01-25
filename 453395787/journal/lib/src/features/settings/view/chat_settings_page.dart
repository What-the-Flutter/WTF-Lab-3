import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../common/utils/locale.dart' as locale;
import '../widget/manage_image_buttons.dart';
import '../widget/mock_message_list.dart';

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
          const MockMessageList(),
          const ManageImageButtons(),
        ],
      ),
    );
  }
}
