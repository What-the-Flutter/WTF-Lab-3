import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../../common/extensions/string_extensions.dart';
import '../../../../common/utils/locale.dart' as locale;
import '../../../../common/widget/confirmation_dialog.dart';
import '../../../../common/widget/floating_bottom_sheet.dart';
import '../../../../routes.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../../view/move_message.dart';
import '../scopes/message_manage_scope.dart';

part 'app_bar_with_actions.dart';
part 'app_bar_with_cancel.dart';
part 'default_app_bar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageManageCubit, MessageManageState>(
      builder: (context, state) {
        return state.map(
          defaultModeState: (defaultModeState) => _DefaultAppBar(
            state: defaultModeState,
          ),
          selectionModeState: (selectionModeState) => _AppBarWithActions(
            state: selectionModeState,
          ),
          editModeState: (editModeState) => const _AppBarWithCancelButton(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
