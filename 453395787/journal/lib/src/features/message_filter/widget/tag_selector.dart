part of '../view/message_filter_view.dart';

class _TagSelector extends StatelessWidget {
  const _TagSelector({
    super.key,
    this.selectedTags,
    required this.onTagsChanged,
  });

  final IList<Tag>? selectedTags;
  final void Function(IList<Tag> tags) onTagsChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Insets.small,
      ),
      child: TagSelectorScope(
        selectedTags: selectedTags,
        child: TagSelector(
          onChanged: onTagsChanged,
          isTagManageItemShown: false,
        ),
      ),
    );
  }
}
