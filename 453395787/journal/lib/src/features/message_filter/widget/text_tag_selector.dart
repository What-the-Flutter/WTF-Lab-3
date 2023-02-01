part of '../view/message_filter_view.dart';

class _TextTagSelector extends StatelessWidget {
  const _TextTagSelector({
    super.key,
    this.selectedTextTags,
    required this.onTextTagsChanged,
  });

  final IList<TextTag>? selectedTextTags;
  final void Function(IList<TextTag> tags) onTextTagsChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Insets.medium,
      ),
      child: TextTagMultiSelectorScope(
        selectedTextTags: selectedTextTags,
        child: TextTagMultiSelector(
          onChanged: onTextTagsChanged,
        ),
      ),
    );
  }
}
