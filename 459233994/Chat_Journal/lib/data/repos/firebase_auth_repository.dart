import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_authentication_service.dart';

class FireBaseAuthRepository {
  final FireBaseAuthService _fireBaseAuthService;

  FireBaseAuthRepository({required fireBaseAuthService})
      : _fireBaseAuthService = fireBaseAuthService;

  Future sinInAnon() async {
    _fireBaseAuthService.signInAnon();
  }

  User? getUser() => _fireBaseAuthService.getUser();
}
