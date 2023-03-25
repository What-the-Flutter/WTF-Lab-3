import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/chat.dart';
import '../../widgets/event_list_title.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().init();
  }

  AppBar _createAppBar() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
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
        const Text(
          'Questionnaire Bot',
          style: TextStyle(
            fontSize: 20,
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
            builder: (_, state) {
              return ListView.separated(
                itemCount: state.chats.length,
                itemBuilder: (_, index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  DateFormat('MMM dd, yyyy').format(
                    DateTime.now(),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
                Navigator.pop(context);
              },
              iconColor: Theme.of(context).disabledColor,
              leading: const Icon(
                Icons.settings,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _createBody(),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManagingPage(),
              ),
            );
            // context.read<HomeCubit>().updateChats(chat);
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
