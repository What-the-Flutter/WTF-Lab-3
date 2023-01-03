part of 'chat_app_bar.dart';

class _AppBarWithCancelButton extends StatelessWidget {
  const _AppBarWithCancelButton({
    super.key,
    required this.chat,
  });

  final ChatProvider chat;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: chat.endEditMode,
        icon: const Icon(Icons.close),
      ),
      title: Text(chat.name),
    );
  }
}
