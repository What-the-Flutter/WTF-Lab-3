import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/home/home_cubit.dart';
import '../../cubit/home/home_state.dart';
import '../../models/chat.dart';
import '../../theme/colors.dart';
import '../../theme/theme_inherited.dart';
import '../../utils/utils.dart';
import '../widgets/home_page/archive_row.dart';
import '../widgets/home_page/chat_card.dart';
import '../widgets/home_page/popup_bottom_menu.dart';
import 'add_chat_page.dart';
import 'event_page.dart';

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
        title: Text(local?.homePage ?? ''),
        centerTitle: true,
        leading: const Icon(Icons.menu_sharp),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.invert_colors),
              onPressed: () {
                ThemeInherited.of(context).switchTheme();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            _createBotBox(context),
            const SizedBox(height: 5),
            _createMessagesList(local),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNewPage(context, const AddChatPage()),
        tooltip: local?.add,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createBotBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: botBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/bot.svg',
              height: 25,
              width: 25,
              color: iconColor,
            ),
            const SizedBox(width: 28),
            Text(
              AppLocalizations.of(context)?.bot ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
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
                onTap: () => openNewPage(
                  context,
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
