part of 'chat_app_bar.dart';

class _DefaultAppBar extends StatelessWidget {
  const _DefaultAppBar({
    super.key,
    required this.chat,
  });

  final ChatProvider chat;

  @override
  Widget build(BuildContext context) => AppBar(title: Text(chat.name));
}
