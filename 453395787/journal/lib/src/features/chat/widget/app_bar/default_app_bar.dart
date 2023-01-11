part of 'chat_app_bar.dart';

class _DefaultAppBar extends StatelessWidget {
  const _DefaultAppBar({
    required this.state,
    super.key,
  });

  final MessageManageDefaultMode state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go('/home');
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
        ),
      ),
      title: Text(
        state.name,
      ),
      actions: [
        IconButton(
          onPressed: () {
            var id = MessageManageScope.of(context).id;
            context.go('/chat/$id/search');
          },
          icon: const Icon(
            Icons.search_outlined,
          ),
        ),
      ],
    );
  }
}
