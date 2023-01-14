import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/journal_bloc_observer.dart';
import 'src/common/data/chat_repository.dart';
import 'src/common/data/database/chat_database.dart';
import 'src/features/theme/theme.dart';
import 'src/journal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = JournalBlocObserver();

  runApp(
    RepositoryProvider(
      create: (context) => ChatDatabase(),
      child: RepositoryProvider(
        create: (context) => ChatRepository(
          provider: context.read<ChatDatabase>(),
        ),
        lazy: false,
        child: const ThemeScope(
          child: JournalApp(),
        ),
      ),
    ),
  );
}
