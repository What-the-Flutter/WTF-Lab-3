import 'package:local_auth/local_auth.dart';

class FingerPrintAuth {
  static Future<bool> authenticate() async {
    final localAuth = LocalAuthentication();
    final bool isAuthenticated;
    try {
      final canCheckBiometrics = await localAuth.canCheckBiometrics;
      final isDeviceSupported = await localAuth.isDeviceSupported();
      if (isDeviceSupported && canCheckBiometrics) {
        isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Scan your fingerprint',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } else {
        isAuthenticated = false;
      }
      return isAuthenticated;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
