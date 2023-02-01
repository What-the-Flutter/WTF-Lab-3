import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'src/common/bloc/journal_bloc_observer.dart';
import 'src/common/features/settings/settings.dart';
import 'src/common/features/theme/theme.dart';
import 'src/features/locale/locale.dart';
import 'src/features/security/data/security_repository.dart';
import 'src/features/security/view/verify_user.dart';
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
  await SecurityRepository.init();
  await SettingsRepository.init();

  runApp(
    LocaleScope(
      child: ThemeScope(
        child: VerifyUser(
          child: SettingsScope(
            child: JournalApp(
              userId: userCredential.user!.uid,
            ),
          ),
        ),
      ),
    ),
  );
}
