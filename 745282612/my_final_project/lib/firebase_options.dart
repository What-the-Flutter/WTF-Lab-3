// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA32L_YpXbPDD6pCNnbTXIXVpkdzXioixs',
    appId: '1:702658349719:web:4698723eb1cb3e3dbf77d2',
    messagingSenderId: '702658349719',
    projectId: 'chat-journal-wtf',
    authDomain: 'chat-journal-wtf.firebaseapp.com',
    storageBucket: 'chat-journal-wtf.appspot.com',
    measurementId: 'G-R91ZZXQ37Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG-s6vwYCNws6qB76IisxhNii1Uz7FAp8',
    appId: '1:702658349719:android:dc3b6f32700748abbf77d2',
    messagingSenderId: '702658349719',
    projectId: 'chat-journal-wtf',
    storageBucket: 'chat-journal-wtf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDooGdadM_0CK23BtTkW3n9kGag57zkoQg',
    appId: '1:702658349719:ios:a21adb69c7db40c0bf77d2',
    messagingSenderId: '702658349719',
    projectId: 'chat-journal-wtf',
    storageBucket: 'chat-journal-wtf.appspot.com',
    iosClientId: '702658349719-a36k6vjum8u0khcs9vbg65rdo7gdv03k.apps.googleusercontent.com',
    iosBundleId: 'com.example.myFinalProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDooGdadM_0CK23BtTkW3n9kGag57zkoQg',
    appId: '1:702658349719:ios:a21adb69c7db40c0bf77d2',
    messagingSenderId: '702658349719',
    projectId: 'chat-journal-wtf',
    storageBucket: 'chat-journal-wtf.appspot.com',
    iosClientId: '702658349719-a36k6vjum8u0khcs9vbg65rdo7gdv03k.apps.googleusercontent.com',
    iosBundleId: 'com.example.myFinalProject',
  );
}
