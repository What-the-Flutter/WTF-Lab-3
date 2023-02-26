import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import 'image_expanded.dart';

class ImageShower extends StatelessWidget {
  final MessageModel message;

  ImageShower({
    super.key,
    required this.message,
  });

  Widget _singleImageShower(BuildContext context, {int? index}) {
    return FutureBuilder<File>(
      future: message.images.length == 1
          ? message.images.first
          : message.images[index!],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.all(Insets.small),
              child: Hero(
                tag: snapshot.data!.path.codeUnits,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Radii.appConstant),
                    border: Border.all(color: Colors.red.shade100),
                  ),
                  child: Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Radii.appConstant),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageExpanded(
                              image: snapshot.data!,
                              heroTag: snapshot.data!.path,
                              imagesCount: message.images.length,
                              index:
                                  message.images.length == 1 ? 1 : index! + 1,
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
                            borderRadius:
                                BorderRadius.circular(Radii.appConstant),
                            child: Image.file(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }

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
            )
          : _multipleImageShower(context);
}
