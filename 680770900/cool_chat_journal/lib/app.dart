import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/chats_cubit.dart';
import 'model/chats_state.dart';
import 'pages/home_page/home_page.dart';
import 'themes/custom_theme.dart';

class CoolChatJournalApp extends StatelessWidget {
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => ChatsCubit(
              initialState: const ChatsState(),
            ),
            child: MaterialApp(
              title: 'Cool Chat Journal',
              theme: CustomTheme.of(context),
              home: const HomePage(appName: 'Cool Chat Journal'),
            ),
          );
        },
      ),
    );
  }
}
