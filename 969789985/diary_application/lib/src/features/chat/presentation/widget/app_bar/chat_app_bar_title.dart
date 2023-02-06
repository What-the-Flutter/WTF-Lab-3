import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../utils/strings.dart';
import '../../cubit/message_control/message_control_cubit.dart';

class ChatAppBarTitle extends StatelessWidget {
  final String chatTitle;

  ChatAppBarTitle({
    super.key,
    required this.chatTitle,
  });

  @override
  Widget build(BuildContext context) {
    return context.watch<MessageControlCubit>().state.isSelectMode
        ? AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: context.read<MessageControlCubit>().state.isEditMode
                ? 0.0
                : 1.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity:
                  context.read<MessageControlCubit>().state.isEditMode ? 0 : 1,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => CustomDialog(
                      dialogTitle: Strings.deleteSelectedMessagesTitle,
                      dialogDescription:
                          const Text(Strings.deleteSelectedMessagesDescription),
                      completeAction: () {
                        context.read<MessageControlCubit>().removeSelected();
                      },
                      cancelVisible: true,
                    ),
                  );
                },
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delete),
                    const SizedBox(width: Insets.small),
                    Text(
                      '${context.read<MessageControlCubit>().selectedCount}',
                    ),
                  ],
                ),
              ),
            ),
          )
        : Text(chatTitle);
  }
}
