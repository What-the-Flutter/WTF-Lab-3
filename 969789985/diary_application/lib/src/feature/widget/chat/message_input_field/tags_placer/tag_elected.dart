import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/chat/message_input/message_input_cubit.dart';
import '../../../theme/theme_scope.dart';

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
      child: state.whenOrNull(
        tagMode: (message, tags, selected, removingMode) => removingMode
            ? IconButton(
                onPressed: () =>
                    context.read<MessageInputCubit>().deleteTag(tag.id),
                icon: const Icon(Icons.close),
              )
            : AnimatedScale(
                duration: const Duration(milliseconds: 150),
                scale: state.when(
                  defaultMode: (message, tags, canSend) => 0.0,
                  tagMode: (message, tags, selected, removingMode) => 1.0,
                ),
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Radii.medium,
                    ),
                  ),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  activeColor: Color(ThemeScope.of(context).state.primaryColor),
                  splashRadius: 0.0,
                  checkColor: Colors.white,
                  value: state.whenOrNull(
                    tagMode: (message, tags, selected, removingMode) =>
                        selected.containsKey(tag.id) ? selected[tag.id] : false,
                  ),
                  onChanged: (value) {
                    context.read<MessageInputCubit>().updateTag(tag.id);
                  },
                ),
              ),
      ),
    );
  }
}
