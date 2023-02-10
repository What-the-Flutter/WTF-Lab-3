import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../common/values/dimensions.dart';
import '../../cubit/message_control/message_control_cubit.dart';
import '../search_bar/search_bar.dart';
import 'resend_bottom_sheet/resend_bottom_sheet.dart';

class ChatAppBarActions extends StatelessWidget {
  final int currentChatId;
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
                    scale:
                        context.read<MessageControlCubit>().state.selectedCount == 1
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
                    onPressed: () {},
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
              SearchBar(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
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
