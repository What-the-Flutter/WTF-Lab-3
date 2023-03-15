import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../theme/theme_cubit.dart';
import '../../widgets/event_list_title.dart';
import '../managing_page/managing_page.dart';
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
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
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
                context.read<ThemeCubit>().toggleTheme();
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
    context.read<HomeCubit>().loadChats();
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () async {
            final chat = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManagingPage(),
              ),
            );
            context.read<HomeCubit>().updateChats(chat);
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
