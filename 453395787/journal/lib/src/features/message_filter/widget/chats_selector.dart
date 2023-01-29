part of '../view/message_filter.dart';

class _ChatsSelectors extends StatefulWidget {
  const _ChatsSelectors({
    super.key,
    required this.chats,
    this.selectedChats,
    required this.onSelectedChatsChanged,
  });

  final IList<Chat> chats;
  final IList<Chat>? selectedChats;
  final void Function(IList<Chat> chats) onSelectedChatsChanged;

  @override
  State<_ChatsSelectors> createState() => _ChatsSelectorsState();
}

class _ChatsSelectorsState extends State<_ChatsSelectors> {
  late IList<Chat> _selectedChats;

  @override
  void initState() {
    super.initState();
    _selectedChats = widget.selectedChats ?? IList([]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chats',
          style: TextStyles.defaultMedium(context),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.chats.length,
            itemBuilder: (context, index) {
              final chat = widget.chats[index];
              return ChatItemSmall(
                text: chat.name,
                icon: chat.icon,
                isSelected: _isSelected(chat),
                onTap: () {
                  _toggleSelection(chat);
                  widget.onSelectedChatsChanged(_selectedChats);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _toggleSelection(Chat chat) {
    if (_isSelected(chat)) {
      setState(() {
        _selectedChats = _selectedChats.remove(chat);
      });
    } else {
      setState(() {
        _selectedChats = _selectedChats.add(chat);
      });
    }
  }

  bool _isSelected(Chat chat) => _selectedChats.contains(chat);
}
