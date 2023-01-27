part of 'chat_input.dart';

class _BlocSynchronization extends StatelessWidget {
  const _BlocSynchronization({
    super.key,
    required this.child,
    required this.onDefaultModeStarted,
    required this.onEditModeStarted,
    required this.inputTextController,
  });

  final Widget child;
  final VoidCallback onDefaultModeStarted;
  final void Function(Message message) onEditModeStarted;
  final TextEditingController inputTextController;

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
              editModeState.message.tags
                  .map(
                    (e) => e.id,
                  )
                  .toIList(),
            );
            context.read<TextTagCubit>().onInputTextChanged(
                  editModeState.message.text,
                );
          },
        );
      },
      child: BlocListener<TextTagCubit, TextTagState>(
        listener: (context, state) {
          state.mapOrNull(selectedState: (selectedState) {
            final text = context.read<TextTagCubit>().autocompleteTagText(
                  text: inputTextController.text,
                  tagText: selectedState.tag.text,
                );

            inputTextController.text = text;
            MessageInputScope.of(context).onTextChanged(text);
          });
        },
        child: child,
      ),
    );
  }
}
