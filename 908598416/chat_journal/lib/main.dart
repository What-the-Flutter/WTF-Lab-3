import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/cubit/chats/chats_cubit.dart';
import 'bloc/cubit/messages/messages_cubit.dart';
import 'bloc/cubit/sign_in/sign_in_cubit.dart';
import 'bloc/cubit/theme_cubit.dart';
import 'data/providers/providers.dart';
import 'ui/screens/splash_screen.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(
              create: (context) => SignInCubit(AuthProvider(
                    firebaseAuth: FirebaseAuth.instance,
                    googleSignIn: GoogleSignIn(),
                    prefs: prefs,
                    firebaseFirestore: firebaseFirestore,
                  ))),
          BlocProvider(
              create: (context) => ChatsCubit(
                    ChatProvider(
                      firebaseFirestore: firebaseFirestore,
                    ),
                  )),
          BlocProvider(
              create: (context) => MessagesCubit(
                    MessageProvider(
                      prefs: prefs,
                      firebaseFirestore: firebaseFirestore,
                      firebaseStorage: firebaseStorage,
                    ),
                  )),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
          return MaterialApp(
            title: 'Chat journal',
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        }));
    //_multiProvider();
  }

}
