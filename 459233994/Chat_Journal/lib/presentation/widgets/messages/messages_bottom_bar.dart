import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/image_message.dart';
import '../../../domain/entities/packed_message.dart';
import '../../../domain/entities/text_message.dart';
import 'inherited_list.dart';

class MessagesBottomBar extends StatefulWidget {

  MessagesBottomBar();

  @override
  State<MessagesBottomBar> createState() => _MessagesBottomBarState();
}

class _MessagesBottomBarState extends State<MessagesBottomBar> {
  Icon _icon = const Icon(
    Icons.add_a_photo,
    color: Color(0xff829399),
  );
  final textController = TextEditingController();

  void _getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      InheritedList.of(context)?.events.add(
            PackedMessage(
              imageMessage: ImageMessage(file: imageFile),
            ),
          );
      InheritedList.of(context)?.notifyParent();
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Icon(
          Icons.label,
          color: Color(0xff829399),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: Color(0xff829399),
                ),
              ),
              hintText: 'Enter event',
            ),
            onChanged: (text) {
              setState(
                () {
                  if (textController.text.isNotEmpty) {
                    _icon = const Icon(
                      Icons.send,
                      color: Color(0xff829399),
                    );
                  } else {
                    _icon = const Icon(
                      Icons.add_a_photo,
                      color: Color(0xff829399),
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
                if (textController.text.isNotEmpty) {
                  InheritedList.of(context)?.events.add(
                        PackedMessage(
                          textMessage: TextMessage(data: textController.text),
                        ),
                      );
                  textController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                  InheritedList.of(context)?.notifyParent();
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
