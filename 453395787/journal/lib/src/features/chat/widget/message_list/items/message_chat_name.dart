part of 'message_item.dart';

class _MessageChatName extends StatelessWidget {
  const _MessageChatName({
    super.key,
    required this.chatName,
  });

  final String chatName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.small,
        top: Insets.none,
        right: Insets.small,
        bottom: Insets.none,
      ),
      child: Text(
        chatName,
        style: TextStyles.messageChatName(context),
      ),
    );
  }
}
