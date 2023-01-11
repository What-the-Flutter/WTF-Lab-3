part of 'chat_input.dart';

class _ChatInputMutableButton extends StatelessWidget {
  const _ChatInputMutableButton({
    super.key,
    required this.onSend,
  });

  final void Function() onSend;

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
        } else {
          return InkWell(
            onLongPress: () async {
              final image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                MessageInputScope.of(context).addImages([image.path]);
              }
            },
            onTap: () async {
              final images = await ImagePicker().pickMultiImage();
              var imagePaths = images.map((e) => e.path).toList();
              MessageInputScope.of(context).addImages(imagePaths);
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
        }
      },
    );
  }
}
