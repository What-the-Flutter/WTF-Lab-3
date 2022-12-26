import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entities/message.dart';
import '../../../entities/message_value.dart';
import '../../screens/travel_screen.dart';
import 'travel_screen_bottom_message.dart';
import 'travel_screen_instruction.dart';
import 'travel_screen_list_message.dart';

class TravelScreenBody extends StatefulWidget {
  const TravelScreenBody({
    super.key,
    required this.isFavorite,
    required this.isSelected,
  });
  final bool isFavorite;
  final bool isSelected;
  @override
  State<TravelScreenBody> createState() => _TravelScreenBodyState();
}

class _TravelScreenBodyState extends State<TravelScreenBody> {
  final controller = TextEditingController();
  bool _isCamera = true;
  @override
  void initState() {
    controller.addListener(_onInputText);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onInputText);
    super.dispose();
  }

  void _onInputText() {
    setState(() {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      controller.text.isEmpty ? _isCamera = true : _isCamera = false;
    });
  }

  void addMessage({required String content, required String type}) {
    if (!_isCamera) {
      setState(
        () {
          TravelScreen.of(context).listMessage.insert(
                0,
                Message(
                  messageContent: content,
                  messageType: type,
                  messageTime: DateTime.now(),
                ),
              );
          controller.text = '';
        },
      );
    }
  }

  void onEventSelected(Message message) {
    setState(
      () {
        message.isSelected = !message.isSelected;
      },
    );
  }

  void addPicterMessage({required XFile? pickedFile, required String type}) {
    if (pickedFile != null) {
      setState(
        () {
          TravelScreen.of(context).listMessage.insert(
                0,
                Message(
                  messageContent: '',
                  messageType: type,
                  messageTime: DateTime.now(),
                  messageImage: Image.file(
                    File(pickedFile.path),
                  ),
                ),
              );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TravelScreen.of(context).listMessage = MessageValue.listMessage;
    TravelScreen.of(context).listFavoriteMesage = TravelScreen.of(context)
        .listMessage
        .where((element) => element.isFavorit == true)
        .toList();
    return Stack(
      children: [
        TravelScreen.of(context).listMessage.length <= 1
            ? const TravelScreenInstruction()
            : TravelScreenListMessage(
                listMessage: widget.isFavorite
                    ? TravelScreen.of(context).listFavoriteMesage
                    : TravelScreen.of(context).listMessage,
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
