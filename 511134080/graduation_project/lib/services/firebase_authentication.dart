import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseInstance;

  FirebaseAuthentication() : _firebaseInstance = FirebaseAuth.instance;

  Future<UserCredential> authenticateAnonymously() async {
    final userCredential = await _firebaseInstance.signInAnonymously();
    return userCredential;
  }
}
