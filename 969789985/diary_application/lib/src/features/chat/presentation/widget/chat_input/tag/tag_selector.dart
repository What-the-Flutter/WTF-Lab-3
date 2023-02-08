import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/database/chat_database.dart';
import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/message_input/message_input_cubit.dart';
import 'tag_card.dart';

class TagSelector extends StatelessWidget {
  final MessageInputState state;

  const TagSelector({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final tags = RepositoryProvider.of<ChatDatabase>(context).tags.value;

    return AnimatedContainer(
      height: state.isTagOpened ? 50.0 : 0.0,
      curve: state.isTagOpened ? Curves.decelerate : Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      child: AnimatedSlide(
        curve: state.isTagOpened ? Curves.decelerate : Curves.fastOutSlowIn,
        offset: state.isTagOpened ? Offset.zero : const Offset(0.0, 1.5),
        duration: const Duration(milliseconds: 250),
        child: Padding(
          padding: const EdgeInsets.only(
            right: Insets.small,
            left: Insets.small,
            bottom: Insets.small,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<MessageInputCubit>().updateTagVisible(),
                  icon: const Icon(Icons.close),
                ),
                for (final tag in tags)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Insets.medium,
                      right: Insets.medium,
                    ),
                    child: TagCard(
                      tag: tag,
                      state: state,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
