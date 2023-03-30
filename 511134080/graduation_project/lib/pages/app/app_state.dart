part of 'app_cubit.dart';

class AppState {
  final bool isAuthenticated;

  AppState({
    this.isAuthenticated = false,
  });

  AppState copyWith({
    bool? authenticated,
  }) =>
      AppState(
        isAuthenticated: authenticated ?? isAuthenticated,
      );
}
