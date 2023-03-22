import 'package:firebase_auth/firebase_auth.dart';

class SignInAnonymously {
  static Future<UserCredential> signInAnonymously() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }
}
