import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  Widget _listTile(int index, List<Chat> chats) {
    final sortedChats =
        List<Chat>.from(chats.where((chatModel) => chatModel.isPinned))
          ..addAll(chats.where((chatModel) => !chatModel.isPinned));
    return EventListTile(
      chatId: sortedChats[index].id,
    );
  }

  AppBar _appBar() => AppBar(
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
            builder: (context, state) => IconButton(
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
            ),
          ),
        ],
      );

  Widget _botButton() => Row(
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

  Widget _body() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor: Theme.of(context).hintColor,
              title: _botButton(),
              visualDensity: const VisualDensity(vertical: 3),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    return _listTile(index, state.chats);
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

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
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

  Widget _drawerHeader() => DrawerHeader(
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

  Widget _drawerSpreadingTile() => ListTile(
        onTap: () {
          context.read<HomeCubit>().share();
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

  Widget _drawerSettingTile() => ListTile(
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

  Widget _drawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _drawerHeader(),
            _drawerSpreadingTile(),
            _drawerSettingTile(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        drawer: _drawer(),
        body: _body(),
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
        bottomNavigationBar: _bottomNavigationBar(),
      );
}
