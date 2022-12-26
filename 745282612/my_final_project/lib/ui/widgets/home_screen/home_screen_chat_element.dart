import 'package:flutter/material.dart';

import '../../../entities/chat.dart';
import '../../../entities/chat_value.dart';
import '../../../utils/constants/app_colors.dart';
import '../hovers/on_hovers_button.dart';

class HomeScreenChatElement extends StatelessWidget {
  HomeScreenChatElement({super.key});

  final List<Chat> chatList = ChatValue.listChat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final itemChat = chatList[index];
        return Column(
          children: [
            HoverButton(
              child: TextButton(
                onPressed: itemChat.url == null
                    ? () {}
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => itemChat.url!,
                          ),
                        );
                      },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.colorLightBlue,
                    foregroundColor: Colors.white,
                    radius: 40,
                    child: itemChat.icon,
                  ),
                  title: Text(
                    itemChat.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: const Text(
                    'No Events. Click to create one',
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
