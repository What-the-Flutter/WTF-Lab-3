import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/database/chat_database.dart';
import '../../../../../../common/models/tag_model.dart';
import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/message_input/message_input_cubit.dart';

class TagElected extends StatelessWidget {
  final TagModel tag;
  final MessageInputState state;

  const TagElected({
    super.key,
    required this.tag,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: state.tagRemoving
          ? IconButton(
              onPressed: () =>
                  RepositoryProvider.of<ChatDatabase>(context).removeTag(tag),
              icon: const Icon(Icons.close),
            )
          : AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: state.isTagOpened && !state.tagRemoving ? 1.0 : 0.0,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Radii.medium,
                  ),
                ),
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                activeColor: Theme.of(context).primaryColorLight,
                splashRadius: 0.0,
                checkColor: Colors.white,
                value: state.tagSelected.containsKey(tag.id)
                    ? state.tagSelected[tag.id]
                    : false,
                onChanged: (value) {
                  context.read<MessageInputCubit>().updateTag(tag.id);
                },
              ),
            ),
    );
  }
}
