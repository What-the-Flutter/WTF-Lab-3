import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/diary_observer.dart';
import 'src/common/themes/repo/theme_repository.dart';
import 'src/common/themes/widget/theme_scope.dart';
import 'src/diary_app.dart';
import 'src/features/chat_list/data/repo/chat_provider.dart';
import 'src/features/chat_list/data/repo/chat_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DiaryObserver();
  await ThemeRepository.initialize();

  runApp(
    RepositoryProvider(
      create: (context) => ChatRepository(
        provider: ChatProvider(),
      ),
      child: const ThemeScope(
        child: DiaryApp(),
      ),
    ),
  );
}
