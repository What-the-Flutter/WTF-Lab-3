import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:local_auth/local_auth.dart';

abstract class ApiSecurityRepository {
  String get securityMode;

  String get passcode;

  bool get isDeviceSupportedBiometrics;

  Future<void> setSecurityMode(String value);

  Future<void> setPasscode(String value);

  IList<BiometricType> get  availableBiometric;

  Future<bool> authenticate();
}
