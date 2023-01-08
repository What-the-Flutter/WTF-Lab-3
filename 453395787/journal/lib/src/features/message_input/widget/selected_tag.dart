part of '../view/chat_input.dart';

class _SelectedTagList extends StatelessWidget {
  const _SelectedTagList({
    super.key,
  });

  static final IList<Tag> tags = [
    const Tag(text: 'done', color: Colors.green),
    const Tag(text: 'todo', color: Colors.grey),
    const Tag(text: 'important', color: Colors.orange),
    const Tag(text: 'music', color: Colors.blue),
    const Tag(text: 'work', color: Colors.purple),
  ].lock;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (_, index) {
          var tag = tags[index];

          return Padding(
            padding: const EdgeInsets.all(
              Insets.small,
            ),
            child: TagItem(
              color: tag.color,
              text: tag.text,
              isSelected: context.watch<MessageInputCubit>().state.message.tags.contains(tag),
              onPressed: (isSelected) {
                print(isSelected);
                if (isSelected) {
                  context.read<MessageInputCubit>().addTag(tag);
                } else {
                  context.read<MessageInputCubit>().removeTag(tag);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  const TagItem({
    super.key,
    required this.color,
    required this.text,
    this.onPressed,
    this.isSelected = false,
    this.isEnabled = false,
  });

  final Color color;
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final void Function(bool)? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        text,
      ),
      labelStyle: TextStyle(
        color: _makeItLight(color),
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: _makeItDark(color),
      selectedColor: Colors.black12, 
      shape: StadiumBorder(
        side: BorderSide(
          width: 1,
          color: color,
        ),
      ),
      onSelected: onPressed ?? (_) {},
      selected: isSelected,
    );
  }

  Color _makeItDark(Color color) {
    return Color.fromARGB(
      color.alpha,
      (color.red * 0.3).round(),
      (color.green * 0.3).round(),
      (color.blue * 0.3).round(),
    );
  }

  Color _makeItLight(Color color) {
    return Color.fromARGB(
      color.alpha,
      min(255, (color.red * 1.5).round()),
      min(255, (color.green * 1.5).round()),
      min(255, (color.blue * 1.5).round()),
    );
  }
}
