import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';
import '../../../../../../utils/strings.dart';
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
                for (var index = 0; index < tagIcons.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Insets.medium,
                      right: Insets.medium,
                    ),
                    child: TagCard(
                      tagIcon: tagIcons[index],
                      tagTitle: tagStrings[index]!,
                      tagIndex: index,
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
