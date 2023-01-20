part of '../view/manage_tags_page.dart';

class _AddEditTagPageBody extends StatefulWidget {
  const _AddEditTagPageBody({
    super.key,
    required this.tagForEdit,
  });

  final Tag tagForEdit;

  @override
  State<_AddEditTagPageBody> createState() => _AddEditTagPageBodyState();
}

class _AddEditTagPageBodyState extends State<_AddEditTagPageBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.tagForEdit.text;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          onChanged: (text) {
            context.read<ManageTagsCubit>().updateTag(text: text);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: TagItem(
            color: widget.tagForEdit.color,
            text: widget.tagForEdit.text,
          ),
        ),
        ColorSelector(
          onTap: (color) {
            context.read<ManageTagsCubit>().updateTag(color: color);
          },
          selectedColor: widget.tagForEdit.color,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: context.read<ManageTagsCubit>().applyChanges,
              child: Text(
                locale.Actions.apply.i18n(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
