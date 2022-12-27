import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../chat_repository.dart';
import '../../utils/styles.dart';

class AddChatPage extends StatefulWidget {
  const AddChatPage({super.key});

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final _textEditingController = TextEditingController();
  int? _selectedIcon;

  bool get canBeAdded =>
      _textEditingController.text.isNotEmpty && _selectedIcon != null;

  final _icons = <IconData>[
    Icons.notes,
    Icons.work_outline,
    Icons.featured_play_list_outlined,
    Icons.family_restroom_outlined,
    Icons.abc_outlined,
    Icons.access_time_outlined,
    Icons.account_balance_outlined,
    Icons.airline_seat_individual_suite_outlined,
    Icons.anchor_outlined,
    Icons.announcement_outlined,
    Icons.architecture_outlined,
    Icons.article_outlined,
    Icons.assessment_outlined,
    Icons.assignment_turned_in_outlined,
    Icons.assistant_photo_outlined,
    Icons.attach_file_outlined,
    Icons.attach_money_outlined,
    Icons.audiotrack_outlined,
    Icons.auto_awesome_mosaic_outlined,
    Icons.auto_awesome_outlined,
    Icons.auto_awesome_motion_outlined,
    Icons.auto_graph_outlined,
    Icons.auto_stories_outlined,
    Icons.ac_unit_outlined,
    Icons.back_hand_outlined,
    Icons.badge_outlined,
    Icons.balance_outlined,
    Icons.beach_access_outlined,
    Icons.bedtime_outlined,
    Icons.bolt_outlined,
    Icons.book_outlined,
    Icons.bookmark_outline,
    Icons.border_color_outlined,
    Icons.brunch_dining_outlined,
    Icons.build_outlined,
    Icons.business_center_outlined,
    Icons.cake_outlined,
    Icons.calendar_month_outlined,
    Icons.call_outlined,
    Icons.camera_outlined,
    Icons.category_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Chat'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.large,
              horizontal: Insets.large,
            ),
            child: TextFormField(
              controller: _textEditingController,
              maxLength: 30,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Name',
                counterText: '${_textEditingController.text.length}/30',
              ),
              onChanged: ((value) {
                setState(() {});
              }),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(Insets.medium),
              itemCount: _icons.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50,
                mainAxisSpacing: Insets.medium,
                crossAxisSpacing: Insets.medium,
              ),
              itemBuilder: ((context, index) {
                return _SelectableIcon(
                  index: index,
                  icon: _icons[index],
                  isSelected: index == _selectedIcon,
                  onTap: (isSelected, index) {
                    if (isSelected) {
                      setState(() {
                        _selectedIcon = null;
                      });
                    } else {
                      setState(() {
                        _selectedIcon = index;
                      });
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: canBeAdded
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                var repo = ChatRepository.get();
                repo.chats = repo.chats.add(Chat(
                  id: Random().nextInt(1000),
                  icon: _icons[_selectedIcon!],
                  messages: IList([]),
                  name: _textEditingController.text,
                ));
                Navigator.pop(context);
              },
            )
          : null,
    );
  }
}

class _SelectableIcon extends StatefulWidget {
  final int index;
  final IconData icon;
  final bool isSelected;
  final void Function(bool isSelected, int index) onTap;

  const _SelectableIcon({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SelectableIcon> createState() => _SelectableIconState();
}

class _SelectableIconState extends State<_SelectableIcon> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.4) : null,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          widget.onTap(widget.isSelected, widget.index);
        },
        child: Icon(
          widget.icon,
        ),
      ),
    );
  }
}
