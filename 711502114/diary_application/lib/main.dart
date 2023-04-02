import 'package:diary_application/data/repository/tag_repository.dart';
import 'package:diary_application/presentation/pages/filter/filter_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'data/provider/firebase_provider.dart';
import 'data/provider/settings_provider.dart';
import 'data/repository/chat_repository.dart';
import 'data/repository/event_repository.dart';
import 'data/repository/settings_repository.dart';
import 'domain/utils/auth.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'presentation/pages/chat/event_cubit.dart';
import 'presentation/pages/creation/creation_cubit.dart';
import 'presentation/pages/home/home_cubit.dart';
import 'presentation/pages/main/menu.dart';
import 'presentation/pages/main/menu_cubit.dart';
import 'presentation/pages/settings/settings_cubit.dart';
import 'presentation/pages/settings/settings_state.dart';
import 'presentation/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = await Auth().user;
  runApp(ChatJournalApplication(user: user));
}

class ChatJournalApplication extends StatelessWidget {
  const ChatJournalApplication({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final provider = FirebaseProvider(user: user);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TagRepository>(
          create: (context) => TagRepository(provider: provider),
        ),
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepository(provider: provider),
          lazy: false,
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(
            provider: provider,
            eventRepository: context.read<EventRepository>(),
          ),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(
            settingsProvider: SettingsProvider(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(
              rep: SettingsRepository(
                settingsProvider: SettingsProvider(),
              ),
            ),
            lazy: false,
          ),
          BlocProvider<MenuCubit>(
            create: (context) => MenuCubit(
              rep: context.read<SettingsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
            ),
          ),
          BlocProvider(create: (_) => CreationCubit()),
          BlocProvider(
            create: (context) => EventCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
              tagRepository: context.read<TagRepository>(),
            ),
          ),
          BlocProvider<FilterCubit>(
            create: (context) => FilterCubit(
              chatRepositoryApi: context.read<ChatRepository>(),
              eventRepositoryApi: context.read<EventRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (_, state) => GetMaterialApp(
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const SplashScreen(child: BottomMenu()),
          ),
        ),
      ),
    );
  }
}
