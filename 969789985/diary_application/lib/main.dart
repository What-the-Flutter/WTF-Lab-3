import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'src/core/data/repository/security/security_repository.dart';
import 'src/core/data/repository/theme/theme_repository.dart';
import 'src/diary_app.dart';
import 'src/feature/cubit/diary_application_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DiaryApplicationObserver();
  await Firebase.initializeApp(
    name: 'DiaryApp',
    options: DefaultFirebaseOptions.currentPlatform
  );
  await ThemeRepository.initialize();
  await SecurityRepository.initialize();

  FirebaseDatabase.instance.setPersistenceEnabled(true);
  final accounting = await FirebaseAuth.instance.signInAnonymously();

  runApp(
    DiaryApp(
      firebaseUid: accounting.user!.uid,
    ),
  );
}
