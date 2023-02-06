import '../utils/verify_method_enum.dart';

abstract class SecurityRepositoryApi {
  static const VerifyMethod defaultVerifyMethod = VerifyMethod.none;

  VerifyMethod get verifyMethod;

  Future<void> setVerifyMethod(VerifyMethod method);

  Future<void> resetToDefault();
}
