part of 'sign_in_cubit.dart';

abstract class SignInState{}

class Unauthenticated extends SignInState {}
class AuthenticationInProgress extends SignInState {}
class Authenticated extends SignInState {}
class AuthenticateError extends SignInState {}
class AuthenticateCanceled extends SignInState {}