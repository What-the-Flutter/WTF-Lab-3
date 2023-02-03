import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../domain/message_model.dart';
import '../../cubit/message_control/message_control_cubit.dart';
import 'image_large.dart';

class ImageShower extends StatelessWidget {
  final MessageModel message;

  ImageShower({
    super.key,
    required this.message,
  });

  Widget _singleImageShower(BuildContext context, String imagePath,
          {int? index}) =>
      Hero(
        tag: message.images.length == 1
            ? message.images.first
            : message.images[index!],
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(Radii.appConstant),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageLarge(
                    imagePath: imagePath,
                    heroTag: message.images.length == 1
                        ? message.images.first
                        : message.images[index!],
                    imagesCount: message.images.length,
                    index: message.images.length == 1 ? 1 : index! + 1,
                  ),
                ),
              );
            },
            onLongPress: () {
              context.read<MessageControlCubit>().selectOne(message);
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300.0),
              child: Padding(
                padding: const EdgeInsets.all(Insets.small),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.appConstant),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _multipleImageShower(BuildContext context) => Container(
        constraints: const BoxConstraints(maxWidth: 300.0),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            for (var index = 0; index < message.images.length; index++)
              _singleImageShower(
                context,
                message.images[index],
                index: index,
              ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => message.images.isEmpty
      ? Container(
          width: Insets.none,
          height: Insets.none,
        )
      : message.images.length == 1
          ? _singleImageShower(
              context,
              message.images.first,
            )
          : _multipleImageShower(context);
}
