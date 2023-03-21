import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/chat.dart';
import '../chat_editor_page/chat_editor_page.dart';
import '../chat_page/chat_page.dart';
import '../settings_page/settings_cubit.dart';
import 'home_cubit.dart';
import 'widgets/manage_panel_dialog.dart';

class HomePage extends StatelessWidget {
  final User? user;
  
  const HomePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(user: user),
      child: HomePageView(user: user),
    );
  }
}

class HomePageView extends StatefulWidget {
  final User? user;

  const HomePageView({
    required this.user,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  void _openManagePanel(BuildContext context, Chat chat) {
    final cubit = context.read<HomeCubit>();

    showModalBottomSheet(
      context: context,
      builder: (context) => ManagePanelDialog(
        chat: chat,
        onDeleteChat: () => cubit.deleteChat(chat.id),
        onSwitchChatPinning: () => cubit.switchChatPinning(chat.id),
        onEditChat: () => Navigator.of(context).push<void>(
          ChatEditorPage.route(
            homeCubit: cubit,
            sourceChat: chat,
          ),
        ),
      ),
    );
  }

  Widget _createChatCard(BuildContext context, Chat chat) {
    final theme = context.read<SettingsCubit>().state.themeData;

    return Card(
      child: InkWell(
        onLongPress: () => _openManagePanel(context, chat),
        onTap: () => Navigator.of(context).push<void>(
          ChatPage.route(
            homeCubit: context.read<HomeCubit>(),
            chatId: chat.id,
            chatName: chat.name,
            user: widget.user,
          ),
        ),
        child: ListTile(
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.background,
                ),
                child: Icon(
                  IconData(chat.iconCode, fontFamily: 'MaterialIcons'),
                ),
              ),
              if (chat.isPinned)
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
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
          subtitle: const Text('_generateSubtitle()'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().updateChats();
    
    final settingsCubit = context.read<SettingsCubit>();

    if (!settingsCubit.state.isInit) {
      settingsCubit.initTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => print('Open settings'),
        ),
        title: const Text('Cool Chat Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: () async => 
              await context.read<SettingsCubit>().switchTheme(),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status.isInitial) {
            context.read<HomeCubit>().updateChats();
          }
        },
        builder:(context, state) {
          if (state.status.isSuccess) {
            final chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) =>
                _createChatCard(context, chats[index]),
            );
          } else if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Oops! Something wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push<void>(
            ChatEditorPage.route(
              homeCubit: context.read<HomeCubit>(),
            ),
          );
        }
      ),
    );
  }
}