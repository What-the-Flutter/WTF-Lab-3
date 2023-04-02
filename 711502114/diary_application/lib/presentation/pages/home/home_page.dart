import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/chat/event_page.dart';
import 'package:diary_application/presentation/pages/creation/add_chat_page.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/widgets/home_page/archive_row.dart';
import 'package:diary_application/presentation/widgets/home_page/chat_card.dart';
import 'package:diary_application/presentation/widgets/home_page/menu_drawer.dart';
import 'package:diary_application/presentation/widgets/home_page/popup_bottom_menu.dart';
import 'package:diary_application/presentation/widgets/home_page/questionnaire_bot_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_cubit.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(local?.homePage ?? '', style: textTheme(context).headline2!),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.invert_colors),
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context).changeTheme();
              },
            ),
          ),
        ],
      ),
      drawer: MenuDrawer(local: local),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const QuestionnaireBot(),
            const SizedBox(height: 5),
            _createMessagesList(local),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNewPageWithAnim(
          const AddChatPage(),
          AnimationType.zoom,
        ),
        tooltip: local?.add,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createMessagesList(AppLocalizations? local) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      final cubit = context.read<HomeCubit>();
      final archived = state.chats.where((c) => c.isArchive);
      final archivedFlag = archived.isNotEmpty ? 1 : 0;
      final info = '${archived.length} ${local?.countArchived ?? ''}';
      final chats = state.chats.where((c) => !c.isArchive).toList();
      return Expanded(
        child: ListView.builder(
          itemCount: chats.length + archivedFlag,
          itemBuilder: (context, index) {
            if (index < chats.length) {
              return InkWell(
                onTap: () => openNewPageWithAnim(
                  MessengerPage(chat: chats[index]),
                ),
                onLongPress: () => _showMenu(cubit, chats[index]),
                child: ChatCard(chat: chats[index]),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  ArchiveRow(archivedInfo: info),
                ],
              );
            }
          },
        ),
      );
    });
  }

  void _showMenu(HomeCubit cubit, Chat chat) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PopupBottomMenu(cubit: cubit, chat: chat),
    );
  }
}
