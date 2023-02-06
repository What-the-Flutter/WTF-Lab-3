part of 'text_tag_selector.dart';

class _TextTagList extends StatelessWidget {
  const _TextTagList({
    super.key,
    required this.tags,
    required this.onPressed,
  });

  final IList<TextTag> tags;
  final void Function(TextTag tag) onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.extraSmall,
            ),
            child: TextTagChip(
              tag: tags[index],
              onPressed: () => onPressed(
                tags[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
