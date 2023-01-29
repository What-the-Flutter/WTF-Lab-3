part of '../view/message_filter.dart';

class _TagSelectors extends StatelessWidget {
  const _TagSelectors({
    super.key,
    this.selectedTags,
    this.selectedTextTags,
    required this.onTagsChanged,
    required this.onTextTagsChanged,
  });

  final IList<Tag>? selectedTags;
  final IList<TextTag>? selectedTextTags;
  final void Function(IList<Tag> tags) onTagsChanged;
  final void Function(IList<TextTag> tags) onTextTagsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.SettingsPage.tagItem.i18n(),
          style: TextStyles.defaultMedium(context),
        ),
        Padding(
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
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: Insets.medium,
          ),
          child: TextTagMultiSelectorScope(
            selectedTextTags: selectedTextTags,
            child: TextTagMultiSelector(
              onChanged: onTextTagsChanged,
            ),
          ),
        ),
      ],
    );
  }
}
