import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/chat/message_input/message_input_cubit.dart';
import '../../../../page/settings/appearance_page.dart';
import 'tag_card.dart';

class TagSelector extends StatelessWidget {
  final MessageInputState state;
  final IList<TagModel> tags;

  const TagSelector({
    super.key,
    required this.state,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: state.when(
        defaultMode: (message, tags, canSend) => 0.0,
        tagMode: (message, tags, selected, removingMode) => 50.0,
      ),
      curve: state.when(
        defaultMode: (message, tags, canSend) => Curves.fastOutSlowIn,
        tagMode: (message, tags, selected, removingMode) => Curves.decelerate,
      ),
      duration: const Duration(milliseconds: 300),
      child: AnimatedSlide(
        curve: state.when(
          defaultMode: (message, tags, canSend) => Curves.fastOutSlowIn,
          tagMode: (message, tags, selected, removingMode) => Curves.decelerate,
        ),
        offset: state.when(
          defaultMode: (message, tags, canSend) => const Offset(0.0, 1.5),
          tagMode: (message, tags, selected, removingMode) => Offset.zero,
        ),
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
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppearancePage(),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
