import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> getOrCreateUser() async {
    if (currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
    return currentUser;
  }
}
