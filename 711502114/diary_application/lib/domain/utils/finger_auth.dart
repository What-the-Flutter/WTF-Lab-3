import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';

class FingerAuth {
  static Future<bool> check() async {
    final auth = LocalAuthentication();

    try {
      if (await auth.canCheckBiometrics && await auth.isDeviceSupported()) {
        return await auth.authenticate(
          localizedReason: '',
          // localizedReason: 'Scan your finger',
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
