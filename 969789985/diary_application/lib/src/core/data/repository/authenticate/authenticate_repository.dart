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
  Future<String> currentUserId() async => await _authenticateOrCurrent();

  FutureOr<String> _authenticateOrCurrent() async {
    if (_fAuthInstance.currentUser != null) {
      logger(
        'Firebase existent user\'s id: ${_fAuthInstance.currentUser!.uid}',
        'Firebase_authentication',
      );
      return _fAuthInstance.currentUser!.uid;
    }

    final account = await _fAuthInstance.signInAnonymously();

    logger(
      'Firebase new user\'s id: ${_fAuthInstance.currentUser!.uid}',
      'Firebase_authentication',
    );

    return account.user!.uid;
  }

  static FirebaseAuth get _fAuthInstance => FirebaseAuth.instance;
}
