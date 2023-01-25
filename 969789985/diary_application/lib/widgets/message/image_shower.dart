import 'dart:io';

import 'package:flutter/material.dart';

import '../../basic/models/message_model.dart';
import '../../ui/utils/dimensions.dart';

class ImageShower extends StatelessWidget {
  final MessageModel message;

  ImageShower({super.key, required this.message});

  Widget _singleImageShower(String imagePath) => Padding(
        padding: const EdgeInsets.all(Insets.small),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Radii.applicationConstant),
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
          width: Insets.none,
          height: Insets.none,
        )
      : message.images.length == 1
          ? _singleImageShower(message.images.first)
          : _multipleImageShower();
}
