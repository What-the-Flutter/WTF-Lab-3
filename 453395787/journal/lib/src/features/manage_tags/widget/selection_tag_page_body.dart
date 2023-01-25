part of '../view/manage_tags_page.dart';

class _SelectionTagPageBody extends StatelessWidget {
  const _SelectionTagPageBody({
    super.key,
    required this.tags,
    this.selectedId,
  });

  final String? selectedId;
  final IList<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageTags(
          tags: tags,
          selectedId: selectedId,
          spacing: Insets.medium,
          alignment: WrapAlignment.start,
          onPressed: (tag) {
            context.read<ManageTagsCubit>().onTagPressed(tag);
          },
        ),
        const Spacer(),
        Row(
          children: [
            TextButton(
              onPressed: selectedId == null
                  ? null
                  : context.read<ManageTagsCubit>().remove,
              child: Text(
                locale.Actions.remove.i18n(),
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: selectedId == null
                  ? context.read<ManageTagsCubit>().startAddingMode
                  : context.read<ManageTagsCubit>().startEditingMode,
              child: Text(
                selectedId == null
                    ? locale.Actions.add.i18n()
                    : locale.Actions.edit.i18n(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
