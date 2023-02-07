import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/firebase_options.dart';
import 'package:my_final_project/services/auth.dart';

Future<Map<String, dynamic>> initApp() async {
  final init = <String, dynamic>{};
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = await AuthServise().getOrCreateUser();
  init['user'] = user;
  return init;
}
