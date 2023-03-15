import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'pages/chat/chat_cubit.dart';
import 'pages/home/home_cubit.dart';
import 'pages/home/home_page.dart';
import 'pages/managing_page/managing_page_cubit.dart';
import 'pages/searching_page/searching_page_cubit.dart';
import 'theme/theme_cubit.dart';

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
              /*  homeCubit: context.read<HomeCubit>(),*/
              ),
        ),
        BlocProvider(
          create: (context) => ManagingPageCubit(
            initState: ManagingPageState(
              chats: chats,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => SearchingPageCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (_, state) {
          return MaterialApp(
            title: 'Chat Journal',
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
