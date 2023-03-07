import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/repository/authenticate/api_authenticate_repository.dart';
import '../../../util/logger.dart';

class AuthenticateRepository implements ApiAuthenticateRepository {
  const AuthenticateRepository();

  @override
  ValueStream<User?> get userStream =>
      FirebaseAuth.instance.authStateChanges().shareValue();

  @override
  Future<void> authenticate() async {
    if (_fAuthInstance.currentUser != null) {
      logger(
        'Firebase existent user\'s id: ${_fAuthInstance.currentUser!.uid}',
        'Firebase_authentication',
      );
      return;
    }

    await _fAuthInstance.signInAnonymously();

    logger(
      'Firebase new user\'s id: ${_fAuthInstance.currentUser!.uid}',
      'Firebase_authentication',
    );
  }

  static FirebaseAuth get _fAuthInstance => FirebaseAuth.instance;
}
