import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/providers/auth_provider.dart';
import '../../../ui/screens/home_screen.dart';
import '../../../ui/screens/login_screen.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authProvider) : super(Unauthenticated());

  final AuthProvider _authProvider;

  Future<bool> handleSignIn() async {
    emit(AuthenticationInProgress());
    return _authProvider.handleSignIn();
  }

  void checkSignedIn(BuildContext context) async {
    final _isLoggedIn = await _authProvider.isLoggedIn();
    if (_isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void handleException() {
    emit(AuthenticateError());
  }

  dynamic getUserFirebaseId() {
    return _authProvider.getUserFirebaseId();
  }

  void dispose() {
    return _authProvider.dispose();
  }

  Future<void> handleSignOut() async {
    _authProvider.handleSignOut();
    emit(Unauthenticated());
  }
}
