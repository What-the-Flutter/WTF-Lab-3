part of 'chat_input.dart';

class _SelectedImagesList extends StatelessWidget {
  const _SelectedImagesList({
    super.key,
    required this.chat,
  });

  final ChatProvider chat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.medium,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: chat.message.images.length + 1,
          itemBuilder: (_, index) {
            if (index != chat.message.images.length) {
              return GestureDetector(
                onDoubleTap: () {
                  chat.removeImageFromSelectedMessage(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(
                    Insets.small,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Radius.medium,
                    ),
                    child: Image.file(
                      File(
                        chat.message.images[index],
                      ),
                    ),
                  ),
                ),
              );
            }
            return IconButton(
              padding: const EdgeInsets.all(
                Insets.extraLarge,
              ),
              onPressed: () async {
                final images = await ImagePicker().pickMultiImage();
                chat.addImagesToInputMessage(
                  images.map((e) => e.path),
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            );
          },
        ),
      ),
    );
  }
}
