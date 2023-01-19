import 'dart:io';

import 'package:flutter/material.dart';

import '../../basic/models/message_model.dart';

class ImageShower extends StatelessWidget {
  ImageShower({super.key, required this.message});

  final MessageModel message;

  Widget _singleImageShower(String imagePath) => Padding(
        padding: const EdgeInsets.all(
          2.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _multipleImageShower() => GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          for (final imagePath in message.images) _singleImageShower(imagePath)
        ],
      );

  @override
  Widget build(BuildContext context) => message.images.isEmpty
      ? Container(
          width: 0,
          height: 0,
        )
      : message.images.length == 1
          ? _singleImageShower(message.images.first)
          : _multipleImageShower();
}
