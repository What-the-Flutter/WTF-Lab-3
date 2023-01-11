part of 'chat_input.dart';

class _SelectedImagesList extends StatelessWidget {
  const _SelectedImagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.medium,
        ),
        child: BlocBuilder<MessageInputCubit, MessageInputState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.message.images.length + 1,
              itemBuilder: (_, index) {
                if (index != state.message.images.length) {
                  return GestureDetector(
                    onDoubleTap: () {
                      MessageInputScope.of(context).removeImage(
                        state.message.images[index],
                      );
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
                            state.message.images[index],
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
                    MessageInputScope.of(context).addImages(
                      images.map((e) => e.path).toList(),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
