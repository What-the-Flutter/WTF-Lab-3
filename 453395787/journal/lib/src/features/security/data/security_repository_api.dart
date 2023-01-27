enum VerifyMethod { faceId, fingerprint, none }

abstract class SecurityRepositoryApi {
  VerifyMethod get verifyMethod;

  Future<void> setVerifyMethod(VerifyMethod method);
}
