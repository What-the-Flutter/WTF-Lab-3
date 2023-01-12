import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/extensions/date_time_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/chat.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/radius.dart';
import '../../../common/utils/text_styles.dart';
import '../../../common/widget/confirmation_dialog.dart';
import '../../../common/widget/floating_bottom_sheet.dart';
import '../../../routes.dart';
import '../../theme/theme.dart';
import '../cubit/chat_overview_cubit.dart';
import '../widget/chat_item.dart';
import '../widget/chat_overview_scope.dart';

part '../widget/chat_list.dart';

part '../widget/bottom_action_sheet.dart';

class ChatOverviewPage extends StatelessWidget {
  const ChatOverviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(
              Radius.extraLarge,
            ),
            onTap: () {
              ThemeScope.of(context).toggleDarkMode();
            },
            onLongPress: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => ChoiceColorSheet(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(
                Insets.medium,
              ),
              child: Icon(
                context.watch<ThemeCubit>().state.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
          ),
        ],
      ),
      body: ChatList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(
            PagePaths.chatAdding.path,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
