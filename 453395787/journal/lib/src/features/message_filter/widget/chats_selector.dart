part of '../view/message_filter_view.dart';

class _ChatsSelector extends StatefulWidget {
  const _ChatsSelector({
    super.key,
    required this.chats,
    this.selectedChats,
    required this.onSelectedChatsChanged,
  });

  final IList<Chat> chats;
  final IList<Chat>? selectedChats;
  final void Function(IList<Chat> chats) onSelectedChatsChanged;

  @override
  State<_ChatsSelector> createState() => _ChatsSelectorState();
}

class _ChatsSelectorState extends State<_ChatsSelector> {
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
        Padding(
          padding: const EdgeInsets.only(
            top: Insets.medium,
          ),
          child: SizedBox(
            height: 60,
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
