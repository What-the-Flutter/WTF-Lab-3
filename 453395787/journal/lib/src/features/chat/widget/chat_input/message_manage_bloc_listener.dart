part of 'chat_input.dart';

class _MessageManageBlocListener extends StatelessWidget {
  const _MessageManageBlocListener({
    super.key,
    required this.child,
    required this.onDefaultModeStarted,
    required this.onEditModeStarted,
  });

  final Widget child;
  final VoidCallback onDefaultModeStarted;
  final void Function(Message message) onEditModeStarted;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageManageCubit, MessageManageState>(
      listener: (context, state) {
        state.mapOrNull(
          defaultModeState: (_) {
            onDefaultModeStarted();
            MessageInputScope.of(context).endEditMode();
            TagSelectorScope.of(context).reset();
            context.read<TextTagCubit>().onInputTextChanged('');
          },
          editModeState: (editModeState) {
            onEditModeStarted(editModeState.message);
            MessageInputScope.of(context).startEditMode(
              editModeState.message,
            );
            TagSelectorScope.of(context).setSelected(
              editModeState.message.tags.map((e) => e.id).toIList(),
            );
            context.read<TextTagCubit>().onInputTextChanged(
                  editModeState.message.text,
                );
          },
        );
      },
      child: child,
    );
  }
}
