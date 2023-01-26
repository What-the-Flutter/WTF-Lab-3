part of 'text_tag_selector.dart';

class TextTagChip extends StatelessWidget {
  const TextTagChip({
    super.key,
    required this.tag,
    this.onPressed,
  });

  final TextTag tag;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: ActionChip(
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(30),
        ),
        label: Text(tag.text),
        onPressed: onPressed,
      ),
    );
  }
}
