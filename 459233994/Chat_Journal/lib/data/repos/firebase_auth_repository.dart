import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_authentication_service.dart';

class FireBaseAuthRepository {
  final FireBaseAuthService fireBaseAuthService;

  FireBaseAuthRepository({required this.fireBaseAuthService});

  Future sinInAnon() async {
   fireBaseAuthService.signInAnon();
  }

  User? getUser() => fireBaseAuthService.getUser();
}