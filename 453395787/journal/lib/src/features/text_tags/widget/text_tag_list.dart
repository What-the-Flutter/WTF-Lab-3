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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...tags.map(
            (tag) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.extraSmall,
              ),
              child: TextTagChip(
                tag: tag,
                onPressed: () => onPressed(tag),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
