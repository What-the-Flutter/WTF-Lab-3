import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/home_page/home_page.dart';
import 'presentation/pages/settings_page/settings_cubit.dart';

class CoolChatJournalApp extends StatefulWidget {
  final User? user;

  const CoolChatJournalApp({
    super.key,
    required this.user,
  });

  @override
  State<CoolChatJournalApp> createState() => _CoolChatJournalAppState();
}

class _CoolChatJournalAppState extends State<CoolChatJournalApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Cool Chat Journal',
              theme: context.read<SettingsCubit>().state.themeData,
              home: HomePage(user: widget.user),
            );
          },
        );
      }),
    );
  }
}
