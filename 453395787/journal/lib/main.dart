import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'src/common/bloc/journal_bloc_observer.dart';
import 'src/common/data/chat_repository.dart';
import 'src/common/data/database/database.dart';
import 'src/common/data/storage.dart';
import 'src/common/data/tag_repository.dart';
import 'src/features/locale/locale.dart';
import 'src/features/theme/theme.dart';
import 'src/journal_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = JournalBlocObserver();
  await Firebase.initializeApp(
    name: 'JournalApp',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var userCredential = await FirebaseAuth.instance.signInAnonymously();
  await ThemeRepository.init();
  await LocaleRepository.init();
  FirebaseDatabase.instance.setLoggingEnabled(true);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => StorageProvider(
            userId: userCredential.user!.uid,
          ),
        ),
        RepositoryProvider(
          create: (context) => Database(
            userId: userCredential.user!.uid,
          ),
        ),
        RepositoryProvider(
          create: (context) => ChatRepository(
            provider: context.read<Database>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TagRepository(
            tagProvider: context.read<Database>(),
          ),
        ),
      ],
      child: const ThemeScope(
        child: LocaleScope(
          child: JournalApp(),
        ),
      ),
    ),
  );
}
