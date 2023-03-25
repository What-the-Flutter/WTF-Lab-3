import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/app/chat_journal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChatJournal(),
  );
}
