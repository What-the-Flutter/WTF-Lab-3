import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import '../search_field/message_search_field.dart';
import 'resend_bottom_sheet/resend_bottom_sheet.dart';

class ChatAppBarActions extends StatelessWidget {
  final FId currentChatId;
  final MessageControlState state;

  const ChatAppBarActions({
    super.key,
    required this.currentChatId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return context.read<MessageControlCubit>().state.isSelectMode
        ? AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: context.read<MessageControlCubit>().state.isEditMode
                ? 0.0
                : 1.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity:
                  context.read<MessageControlCubit>().state.isEditMode ? 0 : 1,
              child: Row(
                children: [
                  AnimatedScale(
                    duration: const Duration(milliseconds: 100),
                    scale: context
                                .read<MessageControlCubit>()
                                .state
                                .selectedCount ==
                            1
                        ? 1.0
                        : 0.0,
                    child: IconButton(
                      onPressed: () {
                        context.read<MessageControlCubit>().startEditMode();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  IconButton(
                    onPressed: () =>
                        context.read<MessageControlCubit>().addToFavorites(),
                    icon: const Icon(Icons.bookmark_border),
                  ),
                  const SizedBox(width: Insets.small),
                  IconButton(
                    onPressed: () {
                      context.read<MessageControlCubit>().unselectAll();
                      Fluttertoast.showToast(msg: 'Text copied to buffer!');
                    },
                    icon: const Icon(Icons.content_copy),
                  ),
                  const SizedBox(width: Insets.small),
                  IconButton(
                    onPressed: () => _showResendBottomSheet(context),
                    icon: const Icon(Icons.turn_right),
                  ),
                  const SizedBox(width: Insets.small),
                ],
              ),
            ),
          )
        : Row(
            children: [
              MessageSearchField(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: IconButton(
                  key: ValueKey<String>(
                    context
                        .read<MessageControlCubit>()
                        .state
                        .isFavoriteMode
                        .toString(),
                  ),
                  icon: Icon(
                      context.read<MessageControlCubit>().state.isFavoriteMode
                          ? Icons.bookmark
                          : Icons.bookmark_border),
                  onPressed: () => context
                          .read<MessageControlCubit>()
                          .state
                          .isFavoriteMode
                      ? context.read<MessageControlCubit>().endFavoriteMode()
                      : context.read<MessageControlCubit>().startFavoriteMode(),
                ),
              ),
            ],
          );
  }

  void _showResendBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      builder: (context) => ResendBottomSheet(
        currentChatId: currentChatId,
        state: state,
      ),
    );
  }
}
