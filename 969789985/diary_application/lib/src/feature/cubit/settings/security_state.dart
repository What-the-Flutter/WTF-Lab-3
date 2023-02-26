part of 'security_cubit.dart';

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.defaultMode({
    required String securityMode,
    required IList<int> passcodeSequence,
    required bool withBiometric,
    required bool isAuth,
    required bool isDeviceSupportedBiometric,
    required IList<BiometricType> availableBiometric,
  }) = _DefaultMode;
}
