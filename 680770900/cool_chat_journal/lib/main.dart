import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/get_it_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userCredential = await FirebaseAuth.instance.signInAnonymously();
  final user = userCredential.user;

  if (user != null) {
    initGetIt(user: user);
    runApp(CoolChatJournalApp(user: user));
  }
}
