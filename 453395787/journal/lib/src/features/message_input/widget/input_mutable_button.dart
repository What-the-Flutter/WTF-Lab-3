part of '../view/chat_input.dart';

class _ChatInputMutableButton extends StatelessWidget {
  const _ChatInputMutableButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInputCubit, MessageInputState>(
      builder: (context, state) {
        if (state.canBeSended) {
          return IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onPressed,
          );
        } else {
          return InkWell(
            onLongPress: () async {
              final image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                context.read<MessageInputCubit>().addImages([image.path]);
              }
            },
            onTap: () async {
              final images = await ImagePicker().pickMultiImage();
              var imagePaths = images.map((e) => e.path).toList();
              context.read<MessageInputCubit>().addImages(imagePaths);
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
