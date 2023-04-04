import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  static Future<bool> authenticateUser() async {
    final _localAuthentication = LocalAuthentication();
    late bool isAuthenticated;
    final isBiometricSupported = await _localAuthentication.isDeviceSupported();
    final canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }
}