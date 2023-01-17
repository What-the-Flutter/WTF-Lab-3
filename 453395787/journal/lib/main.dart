import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/journal_bloc_observer.dart';
import 'src/common/data/chat_repository.dart';
import 'src/common/data/database/chat_database.dart';
import 'src/features/locale/data/locale_repository.dart';
import 'src/features/locale/widget/locale_scope.dart';
import 'src/features/theme/data/theme_repository.dart';
import 'src/features/theme/theme.dart';
import 'src/journal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = JournalBlocObserver();
  await ThemeRepository.init();
  await LocaleRepository.init();

  runApp(
    RepositoryProvider(
      create: (context) => ChatDatabase(),
      child: RepositoryProvider(
        create: (context) => ChatRepository(
          provider: context.read<ChatDatabase>(),
        ),
        lazy: false,
        child: const ThemeScope(
          child: LocaleScope(
            child: JournalApp(),
          ),
        ),
      ),
    ),
  );
}
