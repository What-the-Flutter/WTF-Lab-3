part of 'chat_app_bar.dart';

class _AppBarWithCancelButton extends StatelessWidget {
  const _AppBarWithCancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: context.read<MessageManageCubit>().endEditMode,
        icon: const Icon(Icons.close),
      ),
      title: Text(
        context.read<MessageManageCubit>().state.name,
      ),
    );
  }
}
