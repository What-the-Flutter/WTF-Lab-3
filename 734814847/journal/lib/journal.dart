import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'cubits/chat_cubit.dart';
import 'cubits/chats_state.dart';
import 'cubits/events_cubit.dart';
import 'pages/home_page.dart';
import 'themes/theme.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();

  static _JournalState of(BuildContext context) =>
      context.findAncestorStateOfType<_JournalState>()!;
}

class _JournalState extends State<Journal> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatsCubit(
            chatsState: ChatsState(chats: chats),
          ),
        ),
        BlocProvider(
          create: (context) => EventsCubit(
            chatsCubit: context.read<ChatsCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Journal project',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
