import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/chat.dart';
import '../../utils/custom_theme.dart';
import '../chat_editor_page/chat_editor_page.dart';
import '../chat_page/chat_page.dart';
import '../settings_page/settings_page.dart';
import 'home_cubit.dart';
import 'widgets/manage_panel_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cubit = GetIt.I<HomeCubit>();

  void _onOpenManagePanel({
    required BuildContext context,
    required Chat chat,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ManagePanelDialog(
        chat: chat,
        onDeleteChat: () => _cubit.deleteChat(chat.id),
        onSwitchChatPinning: () => _cubit.switchChatPinning(chat),
        onEditChat: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatEditorPage(
              sourceChat: chat,
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatCard({
    required BuildContext context,
    required List<Chat> chats,
    required Chat chat,
  }) {
    return Card(
      child: InkWell(
        onLongPress: () => _onOpenManagePanel(
          context: context,
          chat: chat,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(
              chatId: chat.id,
              chats: chats,
              chatName: chat.name,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    IconData(chat.iconCode, fontFamily: 'MaterialIcons'),
                    color: Colors.black,
                  ),
                ),
                if (chat.isPinned)
                  Container(
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).themeData.cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.push_pin,
                      size: 20,
                    ),
                  ),
              ],
            ),
            title: Text(chat.name),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit.subscribeChatsStream();
    _cubit.initSettings();
  }

  @override
  void dispose() {
    _cubit.unsubscribeChatsStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _CustomDrawer(),
      appBar: AppBar(
        title: const Text('Cool Chat Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: _cubit.switchThemeType,
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) => ListView.builder(
          itemCount: state.chats.length,
          itemBuilder: (context, index) => _chatCard(
            context: context,
            chats: state.chats, 
            chat: state.chats[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChatEditorPage(),
          ),
        ),
      ),
    );
  }
}

class _CustomDrawer extends StatefulWidget {
  const _CustomDrawer({super.key});

  @override
  State<_CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<_CustomDrawer> {
  final _dateFormat = DateFormat.yMMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: CustomTheme.of(context).themeData.primaryColor,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                _dateFormat.format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(Icons.redeem),
              title: Text('Help spread the world'),
            ),
            onTap: () {
              Navigator.pop(context);
              Share.share('Share message');
            },
          ),
          InkWell(
              child: const ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text('Settings'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsPage(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}