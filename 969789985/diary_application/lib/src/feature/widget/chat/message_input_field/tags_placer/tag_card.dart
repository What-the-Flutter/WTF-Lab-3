import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../cubit/chat/message_input/message_input_cubit.dart';
import 'tag_elected.dart';

class TagCard extends StatelessWidget {
  final TagModel tag;
  final MessageInputState state;

  const TagCard({
    super.key,
    required this.tag,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: state.whenOrNull(
        tagMode: (message, tags, selected, removingMode) =>
            removingMode ? 45.0 : 40.0,
      ),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.circle),
        //border: Border.all(color: Theme.of(context).primaryColorLight),
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Radii.circle),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.circle),
          onLongPress: () {
            context.read<MessageInputCubit>().updateTagRemoving();
          },
          onTap: state.whenOrNull(
            tagMode: (message, tags, selected, removingMode) => removingMode
                ? null
                : () => context.read<MessageInputCubit>().updateTag(tag.id),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Insets.small,
              bottom: Insets.small,
              left: Insets.small,
              right: Insets.medium,
            ),
            child: Row(
              children: [
                const SizedBox(width: Insets.small),
                Icon(
                  IconData(tag.tagIcon, fontFamily: AppIcons.material),
                ),
                const SizedBox(width: Insets.small),
                Text(tag.tagTitle),
                TagElected(tag: tag, state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
