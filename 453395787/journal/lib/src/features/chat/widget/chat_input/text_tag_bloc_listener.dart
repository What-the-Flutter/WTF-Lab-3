part of 'chat_input.dart';

class _TextTagBlocListener extends StatelessWidget {
  const _TextTagBlocListener({
    super.key,
    required this.child,
    required this.inputTextController,
  });

  final Widget child;
  final TextEditingController inputTextController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TextTagCubit, TextTagState>(
      listener: (context, state) {
        state.mapOrNull(
          selectedState: (selectedState) {
            final text = context.read<TextTagCubit>().autocompleteTagText(
                  text: inputTextController.text,
                  tagText: selectedState.tag.text,
                );

            inputTextController.text = text;
            MessageInputScope.of(context).onTextChanged(text);
          },
        );
      },
      child: child,
    );
  }
}
