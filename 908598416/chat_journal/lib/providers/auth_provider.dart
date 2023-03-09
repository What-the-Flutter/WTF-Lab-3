import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../models/app_user.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> isLoggedIn() async {
    final isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    final _googleUser = await googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication? _googleAuth =
          await _googleUser.authentication;
      final AuthCredential _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      final _firebaseUser =
          (await firebaseAuth.signInWithCredential(_credential)).user;

      if (_firebaseUser != null) {
        final QuerySnapshot _result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: _firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> _documents = _result.docs;
        if (_documents.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(_firebaseUser.uid)
              .set({
            FirestoreConstants.nickname: _firebaseUser.displayName,
            FirestoreConstants.id: _firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
          });

          User? _currentUser = _firebaseUser;
          await prefs.setString(FirestoreConstants.id, _currentUser.uid);
          await prefs.setString(
              FirestoreConstants.nickname, _currentUser.displayName ?? '');
        } else {
          final _documentSnapshot = _documents[0];
          final _user = AppUser.fromDocument(_documentSnapshot);
          await prefs.setString(FirestoreConstants.id, _user.id);
          await prefs.setString(FirestoreConstants.nickname, _user.nickname);
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  void handleException() {
    _status = Status.authenticateException;
    notifyListeners();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
