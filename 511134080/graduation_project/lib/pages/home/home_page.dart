import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/chat.dart';
import '../../widgets/chat_list_title.dart';
import '../managing_page/managing_page.dart';
import '../settings/settings_cubit.dart';
import '../settings/settings_page.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _createListTile(int index, List<Chat> chats) {
    final sortedChats =
        List<Chat>.from(chats.where((chatModel) => chatModel.isPinned))
          ..addAll(chats.where((chatModel) => !chatModel.isPinned));
    return EventListTile(
      chatId: sortedChats[index].id,
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Text(
        'Home',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).canvasColor,
      actions: [
        BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return IconButton(
              icon: state.isLight
                  ? const Icon(
                      Icons.sunny,
                    )
                  : const Icon(
                      Icons.dark_mode_outlined,
                    ),
              onPressed: () {
                context.read<SettingsCubit>().toggleTheme();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _createBotButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.smart_toy_outlined,
          size: 32,
          color: Colors.grey.shade800,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          'Questionnaire Bot',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _createBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            onTap: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: Theme.of(context).hintColor,
            title: _createBotButton(),
            visualDensity: const VisualDensity(vertical: 3),
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ListView.separated(
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  return _createListTile(index, state.chats);
                },
                separatorBuilder: (_, __) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _createBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.assignment,
          ),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
          ),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        )
      ],
    );
  }

  Widget _createDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          DateFormat('MMM dd, yyyy').format(
            DateTime.now(),
          ),
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  Widget _createDrawerSpreadingTile() {
    return ListTile(
      onTap: () async {
        await Share.share('Keep track of your life with Chat Journal, '
            'a simple and elegant chat-based journal/notes'
            ' application that makes journaling/note-taking fun, '
            'easy, quick and effortless.\n https://play.google.com/'
            'store/apps/details?id=com.agiletelescope.chatjournal');
      },
      iconColor: Theme.of(context).disabledColor,
      leading: const Icon(
        Icons.redeem,
      ),
      title: Text(
        'Help spread the word',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      ),
    );
  }

  Widget _createDrawerSettingTile() {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        );
      },
      iconColor: Theme.of(context).disabledColor,
      leading: const Icon(
        Icons.settings,
      ),
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      ),
    );
  }

  Widget _createDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createDrawerHeader(),
          _createDrawerSpreadingTile(),
          _createDrawerSettingTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      drawer: _createDrawer(),
      body: _createBody(),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManagingPage(
                  context: context,
                ),
              ),
            );
          },
          elevation: 16,
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }
}
