import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:my_final_project/my_chat_app.dart';
import 'package:my_final_project/services/auth.dart';

import 'firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = await AuthServise().getOrCreateUser();
  FlutterNativeSplash.remove();
  runApp(MainApp(user: user));
}
