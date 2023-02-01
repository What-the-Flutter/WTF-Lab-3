import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/data/repository/chat_repository.dart';
import '../../../common/extensions/date_time_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/features/theme/theme.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../../common/utils/radius.dart';
import '../../../common/utils/text_styles.dart';
import '../../../common/widget/confirmation_dialog.dart';
import '../../../routes.dart';
import '../cubit/chat_overview_cubit.dart';
import '../widget/chat_item.dart';
import '../widget/chat_overview_scope.dart';

part '../widget/bottom_action_sheet.dart';

part '../widget/chat_list.dart';

class ChatOverviewPage extends StatelessWidget {
  const ChatOverviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.Pages.home.i18n(),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(
              Radius.extraLarge,
            ),
            onTap: () {
              ThemeScope.of(context).toggleDarkMode();
            },
            onLongPress: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const ChoiceColorSheet(),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(
                Insets.medium,
              ),
              child: AnimatedThemeIcon(),
            ),
          ),
        ],
      ),
      body: const ChatList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(
            Navigation.addChatPagePath,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
