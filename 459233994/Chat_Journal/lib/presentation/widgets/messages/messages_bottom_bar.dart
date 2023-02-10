import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/packed_message.dart';
import '../app_theme/inherited_app_theme.dart';

class MessagesBottomBar extends StatefulWidget {
  final Function _addToMessages;
  final Function _notifyParent;

  MessagesBottomBar({required addToMessages, required notifyParent})
      : _addToMessages = addToMessages,
        _notifyParent = notifyParent;

  @override
  State<MessagesBottomBar> createState() => _MessagesBottomBarState(
        addToMessage: _addToMessages,
        notifyParent: _notifyParent,
      );
}

class _MessagesBottomBarState extends State<MessagesBottomBar> {
  Icon _icon = const Icon(
    Icons.add_a_photo,
    color: Color(0xff829399),
  );
  final _textController = TextEditingController();
  final Function _addToMessages;
  final Function _notifyParent;

  _MessagesBottomBarState({required addToMessage, required notifyParent})
      : _addToMessages = addToMessage,
        _notifyParent = notifyParent;

  void _getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      _addToMessages(
        PackedMessage(
          imageData: imageFile,
        ),
      );
      _notifyParent();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          Icons.label,
          color: InheritedAppTheme.of(context)!.getTheme.iconColor,
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _textController,
            decoration:  InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: InheritedAppTheme.of(context)!.getTheme.textColor,
                ),
              ),
              hintText: 'Enter event',
            ),
            onChanged: (text) {
              setState(
                () {
                  if (_textController.text.isNotEmpty) {
                    _icon = Icon(
                      Icons.send,
                      color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                    );
                  } else {
                    _icon = Icon(
                      Icons.add_a_photo,
                      color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                    );
                  }
                },
              );
            },
          ),
        ),
        InkWell(
          child: _icon,
          onTap: () {
            setState(
              () {
                if (_textController.text.isNotEmpty) {
                  _addToMessages(
                    PackedMessage(textData: _textController.text),
                  );
                  _textController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                  _notifyParent();
                } else {
                  _getFromGallery();
                }
              },
            );
          },
        ),
      ],
    );
  }
}
