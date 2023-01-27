part of 'message_item.dart';

class _MessageImages extends StatelessWidget {
  const _MessageImages({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    if (message.hasSingleImage) {
      return _SingleImage(
        image: message.images.first,
      );
    } else if (message.images.length.isEven) {
      return _EvenAmountOfImages(
        images: message.images,
      );
    }

    return _OddAmountOfImages(
      images: message.images,
    );
  }
}

class _SingleImage extends StatelessWidget {
  const _SingleImage({
    super.key,
    required this.image,
  });

  final Future<File> image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(
          Radius.medium,
        ),
        child: FutureBuilder<File>(
          future: image,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const CircularProgressIndicator();
              } else {
                return Image.file(
                  snapshot.data!,
                  fit: BoxFit.cover,
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}

class _EvenAmountOfImages extends StatelessWidget {
  const _EvenAmountOfImages({
    super.key,
    required this.images,
    this.skipFirst = false,
  });

  final IList<Future<File>> images;
  final bool skipFirst;

  @override
  Widget build(BuildContext context) {
    var imageAmount = images.length;
    if (skipFirst) imageAmount--;

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(
        imageAmount,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(
              Insets.extraSmall,
            ),
            child: _SingleImage(
              image: images[skipFirst ? index + 1 : index],
            ),
          );
        },
      ),
    );
  }
}

class _OddAmountOfImages extends StatelessWidget {
  const _OddAmountOfImages({
    super.key,
    required this.images,
  });

  final IList<Future<File>> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SingleImage(
          image: images.first,
        ),
        _EvenAmountOfImages(
          images: images,
          skipFirst: true,
        ),
      ],
    );
  }
}
