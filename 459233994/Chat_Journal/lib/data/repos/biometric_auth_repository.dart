import '../services/biometric_auth_service.dart';


class BiometricAuthRepository {
  static Future<bool> authenticateUser() async {
    return BiometricAuthService.authenticateUser();
  }
}