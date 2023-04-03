import 'package:local_auth/local_auth.dart';

class FingerprintAuthentication {
  final localAuth = LocalAuthentication();

  FingerprintAuthentication();

  Future<bool> authenticate() async {
    final canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
    final isDeviceSupported = await localAuth.isDeviceSupported();
    if (canAuthenticateWithBiometrics && isDeviceSupported) {
      final availableBiometrics = await localAuth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty &&
          availableBiometrics.contains(BiometricType.weak)) {
        try {
          final didAuthenticate = await localAuth.authenticate(
            localizedReason: 'Please authenticate',
            options: const AuthenticationOptions(
              biometricOnly: true,
              useErrorDialogs: true,
            ),
          );
          return didAuthenticate;
        } catch (exception) {
          rethrow;
        }
      }
    }
    return false;
  }
}
