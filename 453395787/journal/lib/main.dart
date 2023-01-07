import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/journal_app.dart';
import 'src/common/data/chat_provider.dart';
import 'src/common/data/chat_repository.dart';
import 'src/common/utils/journal_bloc_observer.dart';
import 'src/common/utils/preferences.dart';
import 'src/features/navigation/cubit/navigation_cubit.dart';
import 'src/features/theme/cubit/theme_cubit.dart';
import 'src/features/theme/data/theme_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemePreferences.init();
  Bloc.observer = JournalBlocObserver();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ChatRepository(
            provider: ChatProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ThemeRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(
              repository: context.read<ThemeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
        ],
        child: const JournalApp(),
      ),
    ),
  );
}
