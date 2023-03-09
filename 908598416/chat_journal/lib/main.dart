import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/splash_page.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final _prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: _prefs));
}

class App extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  App({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return _multiProvider();
  }

  MultiProvider _multiProvider() {
    return MultiProvider(
    providers: _providers(),
    child: _changeNotifierProvider(),
  );
  }

  ChangeNotifierProvider<ThemeProvider> _changeNotifierProvider() {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
          builder: (context, themeNotifier, child) {
            return MaterialApp(
              title: 'Chat journal',
              theme: themeNotifier.isDark
                  ? ThemeData(
                brightness: Brightness.dark,
              )
                  : ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green
              ),
              debugShowCheckedModeBanner: false,
              home: SplashPage(),
            );
          }),
    );
  }

  List<SingleChildWidget> _providers() {
    return [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(
          firebaseAuth: FirebaseAuth.instance,
          googleSignIn: GoogleSignIn(),
          prefs: prefs,
          firebaseFirestore: firebaseFirestore,
        ),
      ),
      Provider<SettingProvider>(
        create: (_) => SettingProvider(
          prefs: prefs,
          firebaseFirestore: firebaseFirestore,
          firebaseStorage: firebaseStorage,
        ),
      ),
      Provider<HomeProvider>(
        create: (_) => HomeProvider(
          firebaseFirestore: firebaseFirestore,
        ),
      ),
      Provider<ChatProvider>(
        create: (_) => ChatProvider(
          prefs: prefs,
          firebaseFirestore: firebaseFirestore,
          firebaseStorage: firebaseStorage,
        ),
      ),
    ];
  }
}
