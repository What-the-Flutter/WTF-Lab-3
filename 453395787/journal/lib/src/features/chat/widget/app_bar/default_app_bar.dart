part of 'chat_app_bar.dart';

class _DefaultAppBar extends StatelessWidget {
  const _DefaultAppBar({
    required this.state,
    super.key,
  });

  final MessageManageDefaultModeState state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go(
            Navigation.homePagePath,
          );
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
            final id = MessageManageScope.of(context).state.id;
            context.go(
              Navigation.chatSearchPagePath.withArgs(
                {':chatId': '$id'},
              ),
            );
          },
          icon: const Icon(
            Icons.search_outlined,
          ),
        ),
      ],
    );
  }
}
