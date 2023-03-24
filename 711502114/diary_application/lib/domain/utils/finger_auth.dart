import 'package:local_auth/local_auth.dart';

class FingerAuth {
  static Future<bool> check() async {
    final auth = LocalAuthentication();

    try {
      if (await auth.canCheckBiometrics && await auth.isDeviceSupported()) {
        return await auth.authenticate(
          localizedReason: '',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
