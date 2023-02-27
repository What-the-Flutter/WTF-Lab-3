import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repository/security/api_security_repository.dart';
import '../../../util/logger.dart';
import '../../../util/resources/strings.dart';

enum SecurityMode {
  noneSecurity(AuthSelections.noneSecurity),
  withPasscode(AuthSelections.withPasscode),
  withFingerprint(AuthSelections.withFingerprint),
  withFaceId(AuthSelections.withFaceId),
  withPasscodeAndBiometric(AuthSelections.withPasscodeAndBiometric);

  final String securityMode;

  const SecurityMode(this.securityMode);
}

class SecurityRepository implements ApiSecurityRepository {
  static const String _securityModeKey =
      'com.wtflab.diary_application_security_mode';
  static const String _securityPasscodeKey =
      'com.wtflab.diary_application_passcode';

  static String _securityMode = SecurityMode.noneSecurity.securityMode;

  static String _passcode = '';

  static bool _isDeviceSupportedBiometrics = false;

  static List<BiometricType> _availableBiometric = [];

  static Future<void> initialize() async {
    final preference = await SharedPreferences.getInstance();

    _securityMode = await preference.getString(_securityModeKey) ??
        SecurityMode.noneSecurity.securityMode;

    logger(
      'Security mode is: $_securityMode',
      'Preferences security mode',
    );

    _passcode = await preference.getString(_securityPasscodeKey) ?? '';

    logger(
      'Current_passcode: $_passcode',
      'Preferences passcode',
    );

    _isDeviceSupportedBiometrics =
        await LocalAuthentication().canCheckBiometrics ||
            await LocalAuthentication().isDeviceSupported();

    logger(
      'Device can support biometrics: $_isDeviceSupportedBiometrics',
      'Biometric_possibility',
    );

    _availableBiometric = await LocalAuthentication().getAvailableBiometrics();
  }

  @override
  String get securityMode => _securityMode;

  @override
  String get passcode => _passcode;

  @override
  bool get isDeviceSupportedBiometrics => _isDeviceSupportedBiometrics;

  @override
  IList<BiometricType> get availableBiometric => _availableBiometric.toIList();

  @override
  Future<void> setSecurityMode(String value) async {
    final preferences = await SharedPreferences.getInstance();

    logger(
      'The value of security mode is: $value',
      'Preference_security_mode',
    );

    await preferences.setString(_securityModeKey, value);
  }

  @override
  Future<void> setPasscode(String value) async {
    final preferences = await SharedPreferences.getInstance();

    logger(
      'The hash of passcode is: $value',
      'Preference_security_passcode_hash',
    );

    await preferences.setString(_securityPasscodeKey, value);
  }

  @override
  Future<bool> authenticate() async {
    try {
      if (!isDeviceSupportedBiometrics) return false;

      return await LocalAuthentication().authenticate(
        authMessages: const [
          AndroidAuthMessages(
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
          ),
        ],
        localizedReason: ' ',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      logger('AuthError: $e', 'Local_Authentication_error');
      return false;
    }
  }
}
