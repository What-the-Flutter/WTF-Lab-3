import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/chat/message_input/message_input_cubit.dart';

class ImagePlacerBox extends StatelessWidget {
  final MessageInputState state;

  const ImagePlacerBox({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state.message.images.isEmpty
        ? Container(height: Insets.none)
        : SizedBox(
            height: 200.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.medium),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.message.images.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Insets.medium),
                      child: FutureBuilder<File>(
                        future: state.message.images[index],
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const CircularProgressIndicator();
                            } else {
                              return Image.file(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              );
                            }
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
