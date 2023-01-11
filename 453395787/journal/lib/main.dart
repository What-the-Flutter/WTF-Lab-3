import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/journal_bloc_observer.dart';
import 'src/common/data/chat_provider.dart';
import 'src/common/data/chat_repository.dart';
import 'src/features/theme/theme.dart';
import 'src/journal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = JournalBlocObserver();

  runApp(
    RepositoryProvider(
      create: (context) => ChatRepository(
        provider: ChatProvider(),
      ),
      child: const ThemeScope(
        child: JournalApp(),
      ),
    ),
  );
}
