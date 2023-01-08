import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/data/chat_repository.dart';
import '../../../../common/utils/confirmation_dialog.dart';
import '../../../../common/utils/floating_bottom_sheet.dart';
import '../../../move_messages/view/move_message.dart';
import '../../../navigation/cubit/navigation_cubit.dart';
import '../../cubit/message_manage_cubit.dart';

part 'app_bar_with_actions.dart';
part 'app_bar_with_cancel.dart';
part 'default_app_bar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageManageCubit, MessageManageState>(
      builder: (context, state) {
        return state.map(
          defaultMode: (defaultMode) => _DefaultAppBar(
            state: defaultMode,
          ),
          selectionMode: (selectionMode) => _AppBarWithActions(
            state: selectionMode,
          ),
          editMode: (editMode) => const _AppBarWithCancelButton(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
