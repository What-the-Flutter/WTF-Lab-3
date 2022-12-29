import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/ui/widgets/travel_screen/travel_screen_bottom_message.dart';
import 'package:my_final_project/ui/widgets/travel_screen/travel_screen_instruction.dart';
import 'package:my_final_project/ui/widgets/travel_screen/travel_screen_list_message.dart';
import 'package:provider/provider.dart';

class TravelScreenBody extends StatefulWidget {
  final String title;
  final bool isFavorite;
  final bool isSelected;
  final List<Event> listEvent;

  const TravelScreenBody({
    super.key,
    required this.isFavorite,
    required this.isSelected,
    required this.listEvent,
    required this.title,
  });

  @override
  State<TravelScreenBody> createState() => _TravelScreenBodyState();
}

class _TravelScreenBodyState extends State<TravelScreenBody> {
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

  void addMessage({
    required String content,
    required String type,
  }) {
    if (!_isCamera) {
      setState(
        () {
          widget.listEvent.insert(
            0,
            Event(
              messageContent: content,
              messageType: type,
              messageTime: DateTime.now(),
              isFavorit: false,
              isSelected: false,
            ),
          );
          controller.text = '';
        },
      );
    }
  }

  void onEventSelected(int index) {
    setState(
      () {
        final event = widget.listEvent[index];
        widget.listEvent[index] = event.copyWith(isSelected: !event.isSelected);
      },
    );
  }

  void addPicterMessage({
    required XFile? pickedFile,
    required String type,
  }) {
    if (pickedFile != null) {
      setState(
        () {
          widget.listEvent.insert(
            0,
            Event(
              messageContent: 'Image Entry',
              messageType: type,
              messageTime: DateTime.now(),
              messageImage: Image.file(
                File(pickedFile.path),
              ),
              isFavorit: false,
              isSelected: false,
            ),
          );
        },
      );
      Provider.of<ChatProvider>(context, listen: false).isUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.listEvent.isEmpty
            ? Instruction(title: widget.title)
            : TravelScreenListMessage(
                listMessage: widget.isFavorite
                    ? widget.listEvent
                        .where((element) => element.isFavorit)
                        .toList()
                    : widget.listEvent,
                isSelected: widget.isSelected,
                onSelected: onEventSelected,
              ),
        TravelScreenBottomMessage(
          controller: controller,
          isCamera: _isCamera,
          addMessage: addMessage,
          addPicter: addPicterMessage,
        ),
      ],
    );
  }
}
