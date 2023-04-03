import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/app/app_cubit.dart';
import 'pages/app/chat_journal.dart';
import 'pages/main/main_page_cubit.dart';
import 'pages/settings/settings_cubit.dart';
import 'providers/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final settingsProvider = SettingsProvider();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => MainPageCubit(provider: settingsProvider),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(provider: settingsProvider),
          lazy: false,
        ),
      ],
      child: const ChatJournal(),
    ),
  );
}
