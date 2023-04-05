import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../widgets/chat_list_title.dart';
import '../../widgets/custom_drawer.dart';
import '../managing_page/managing_page.dart';
import '../settings/settings_cubit.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Home',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: Theme.of(context).iconTheme,
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
  }

  Widget _listTile(int index, List<Chat> chats) {
    final sortedChats =
        List<Chat>.from(chats.where((chatModel) => chatModel.isPinned))
          ..addAll(chats.where((chatModel) => !chatModel.isPinned));
    return ChatListTile(
      chatId: sortedChats[index].id,
    );
  }

  Widget _botButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.smart_toy_outlined,
          size: 32,
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          'Questionnaire Bot',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _body(HomeState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            onTap: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: Theme.of(context).highlightColor,
            title: _botButton(),
            visualDensity: const VisualDensity(vertical: 3),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: state.chats.length,
            itemBuilder: (context, index) {
              return _listTile(index, state.chats);
            },
            separatorBuilder: (_, __) {
              return const Divider(
                thickness: 2,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _floatingActionButton() {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(context),
        drawer: const CustomDrawer(),
        body: _body(state),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }
}
