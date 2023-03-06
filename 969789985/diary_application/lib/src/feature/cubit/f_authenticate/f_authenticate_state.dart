part of 'f_authenticate_cubit.dart';

@freezed
class FAuthenticateState with _$FAuthenticateState {
  const factory FAuthenticateState.unauthenticated() = _Unauthenticated;

  const factory FAuthenticateState.authenticate({
    required String currentUserId,
  }) = _Authenticate;
}
