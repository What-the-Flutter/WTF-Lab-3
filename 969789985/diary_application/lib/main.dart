import 'package:bloc/bloc.dart';
import 'package:diary_application/src/feature/cubit/diary_application_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/core/data/repository/security/security_repository.dart';
import 'src/core/data/repository/theme/theme_repository.dart';
import 'src/diary_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DiaryApplicationObserver();

  await Firebase.initializeApp(
    name: 'DiaryApplication',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseDatabase.instance.setPersistenceEnabled(true);

  await ThemeRepository.initialize();
  await SecurityRepository.initialize();

  runApp(
    const DiaryApp(),
  );
}
