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
      title: Text(state.name),
      actions: [
        IconButton(
          onPressed: () {
            context.read<NavigationCubit>().openSearchPage(
                  context.read<MessageManageCubit>().id,
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
