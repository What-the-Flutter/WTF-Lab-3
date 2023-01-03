part of 'chat_input.dart';

class _ChatInputMutableButton extends StatelessWidget {
  const _ChatInputMutableButton({
    super.key,
    required this.onSendPressed,
  });

  final void Function() onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        if (!chat.isInputImagesEmpty || chat.canBeSended) {
          return IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onSendPressed,
          );
        } else {
          return InkWell(
            onLongPress: () async {
              final image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                chat.setImagesToInputMessage([image.path]);
              }
            },
            onTap: () async {
              final images = await ImagePicker().pickMultiImage();
              var imagePaths = images.map((e) => e.path).toList();
              imagePaths.addAll(chat.message.images);
              chat.setImagesToInputMessage(imagePaths);
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
