import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  FirebaseAuthentication();

  Future<UserCredential> authenticateAnonymously() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }
}
