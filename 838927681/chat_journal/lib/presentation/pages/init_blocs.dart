import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/provider/firebase_provider.dart';
import '../../data/provider/settings_provider.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/event_repository.dart';
import '../../data/repository/settings_repository.dart';
import '../../data/repository/tags_repository.dart';
import '../../theme/themes.dart';
import '../widgets/splash_screen.dart';
import 'chat_page/chat_page_cubit.dart';
import 'create_chat_page/create_chat_cubit.dart';
import 'filter_page/filter_cubit.dart';
import 'home_page/home_page_cubit.dart';
import 'main_page.dart';
import 'main_page/app_cubit.dart';
import 'main_page/app_state.dart';
import 'settings_page/settings_cubit.dart';
import 'settings_page/settings_state.dart';
import 'statistics/statistics_cubit.dart';
import 'timeline_page/timeline_cubit.dart';

class InitBlocs extends StatelessWidget {
  final FirebaseProvider firebaseProvider;
  final SettingsProvider settingsProvider;
  final User? user;

  InitBlocs({
    required this.user,
    required this.settingsProvider,
    super.key,
  }) : firebaseProvider = FirebaseProvider(user: user);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepository(
            provider: firebaseProvider,
          ),
          lazy: false,
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(
            provider: firebaseProvider,
            eventRepository: context.read<EventRepository>(),
          ),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) =>
              SettingsRepository(settingsProvider: settingsProvider),
        ),
        RepositoryProvider<TagRepository>(
          create: (context) => TagRepository(provider: firebaseProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(
              settingsRepository: SettingsRepository(
                settingsProvider: SettingsProvider(),
              ),
            ),
            lazy: false,
          ),
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              settingsRepository: context.read<SettingsRepository>(),
            ),
            lazy: false,
          ),
          BlocProvider<ChatCubit>(
            create: (context) => ChatCubit(
              eventRepository: context.read<EventRepository>(),
              chatRepository: context.read<ChatRepository>(),
              tagRepository: context.read<TagRepository>(),
            ),
          ),
          BlocProvider<CreateChatCubit>(
            create: (context) => CreateChatCubit(
              chatRepository: context.read<ChatRepository>(),
            ),
          ),
          BlocProvider<HomePageCubit>(
            create: (context) => HomePageCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
            ),
          ),
          BlocProvider<TimelineCubit>(
            create: (context) => TimelineCubit(
              eventRepository: context.read<EventRepository>(),
              chatRepository: context.read<ChatRepository>(),
              tagRepository: context.read<TagRepository>(),
            ),
          ),
          BlocProvider<FilterCubit>(
            create: (context) => FilterCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
            ),
          ),
          BlocProvider<StatisticsCubit>(
            create: (context) => StatisticsCubit(
              context.read<EventRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final appState = state;
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return MaterialApp(
                  theme:
                      state.isLightTheme ? Themes.lightTheme : Themes.darkTheme,
                  debugShowCheckedModeBanner: false,
                  home: SplashScreen(
                    child: ChatJournal(
                      settingsState: state,
                      appState: appState,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
