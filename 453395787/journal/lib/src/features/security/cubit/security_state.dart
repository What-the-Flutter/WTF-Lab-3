part of 'security_cubit.dart';

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.initial({
    required VerifyMethod verifyMethod,
  }) = _Initial;

  const factory SecurityState.success() = _Success;
}
