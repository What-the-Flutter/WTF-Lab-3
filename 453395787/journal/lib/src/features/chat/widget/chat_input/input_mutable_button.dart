part of 'chat_input.dart';

class _ChatInputMutableButton extends StatelessWidget {
  const _ChatInputMutableButton({
    super.key,
    required this.onSend,
  });

  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInputCubit, MessageInputState>(
      builder: (context, state) {
        if (state.canBeSent) {
          return IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onSend,
          );
        }

        return InkWell(
          onLongPress: () async {
            final image = await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
            if (image != null) {
              MessageInputScope.of(context).addImages([
                File(image.path),
              ].lock);
            }
          },
          onTap: () async {
            final images = await ImagePicker().pickMultiImage();

            MessageInputScope.of(context).addImages(images
                .map(
                  (e) => File(e.path),
                )
                .toIList());
          },
          child: const Padding(
            padding: EdgeInsets.all(
              Insets.medium,
            ),
            child: Icon(
              Icons.photo_album_outlined,
            ),
          ),
        );
      },
    );
  }
}
