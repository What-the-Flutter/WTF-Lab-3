import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

abstract class ApiAuthenticateRepository {

  ValueStream<User?> get userStream;

  Future<void> authenticate();

}
