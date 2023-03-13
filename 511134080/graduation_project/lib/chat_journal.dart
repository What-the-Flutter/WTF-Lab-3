import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/pages/chat/chat_cubit.dart';
import 'package:graduation_project/pages/home/home_cubit.dart';
import 'package:graduation_project/pages/managing_page/managing_page_cubit.dart';
import 'package:graduation_project/theme/theme_cubit.dart';

import 'constants.dart';
import 'pages/home/home_page.dart';

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(
            initState: HomeState(chats: chats),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => ChatCubit(
            homeCubit: context.read<HomeCubit>(),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => ManagingPageCubit(
            homeCubit: context.read<HomeCubit>(),
            initState: ManagingPageState(
              chats: chats,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
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
