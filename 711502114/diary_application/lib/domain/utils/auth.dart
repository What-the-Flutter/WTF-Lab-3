import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  User? get _user => _auth.currentUser;

  Future<User?> get user async {
    if (_user == null) await _auth.signInAnonymously();
    return _user;
  }
}
