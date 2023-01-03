import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_bottom_message.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_instruction.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_list_message.dart';

class EventScreenBody extends StatefulWidget {
  final String title;
  final bool isFavorite;
  final bool isSelected;
  final List<Event> listEvent;
  final bool isSearch;

  const EventScreenBody({
    super.key,
    required this.isFavorite,
    required this.isSelected,
    required this.listEvent,
    required this.title,
    required this.isSearch,
  });

  @override
  State<EventScreenBody> createState() => _EventScreenBodyState();
}

class _EventScreenBodyState extends State<EventScreenBody> {
  late final TextEditingController controller;
  bool _isCamera = true;

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(_onInputText);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onInputText);
    super.dispose();
  }

  void _onInputText() {
    setState(
      () {
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        controller.text.isEmpty ? _isCamera = true : _isCamera = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.listEvent.isEmpty
            ? Instruction(title: widget.title)
            : EventScreenListMessage(
                listMessage: widget.isFavorite
                    ? widget.listEvent
                        .where((element) => element.isFavorit)
                        .toList()
                    : widget.listEvent,
                isSelected: widget.isSelected,
                isSearch: widget.isSearch,
              ),
        widget.isSearch
            ? const SizedBox()
            : EventScreenBottomMessage(
                controller: controller,
                isCamera: _isCamera,
              ),
      ],
    );
  }
}
