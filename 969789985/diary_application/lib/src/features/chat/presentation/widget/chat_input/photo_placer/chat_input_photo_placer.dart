import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/message_input/message_input_cubit.dart';

class ChatInputPhotoPlacer extends StatelessWidget {
  final MessageInputState state;

  const ChatInputPhotoPlacer({
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
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Insets.medium),
                      child: Image.file(
                        File(
                          state.message.images[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
