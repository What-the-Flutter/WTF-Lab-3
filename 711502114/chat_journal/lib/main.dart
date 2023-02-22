import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubit/creation/creation_cubit.dart';
import 'cubit/event/event_cubit.dart';
import 'cubit/home/home_cubit.dart';
import 'cubit/menu/menu_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'cubit/theme/theme_state.dart';
import 'database/repository/chat_repository.dart';
import 'database/repository/event_repository.dart';
import 'l10n/l10n.dart';
import 'theme/theme_preferences.dart';
import 'ui/pages/menu.dart';

void main() async => runApp(const ChatJournalApplication());

class ChatJournalApplication extends StatelessWidget {
  const ChatJournalApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (_) => ChatRepository(),
        ),
        RepositoryProvider<EventRepository>(
          create: (_) => EventRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(ThemePreferences()),
            lazy: false,
          ),
          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(
            create: (context) => HomeCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
            ),
          ),
          BlocProvider(create: (_) => CreationCubit()),
          BlocProvider(
            create: (context) => EventCubit(
              eventRepository: context.read<EventRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, state) => MaterialApp(
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const BottomMenu(),
          ),
        ),
      ),
    );
  }
}
