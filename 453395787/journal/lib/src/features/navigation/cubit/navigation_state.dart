part of 'navigation_cubit.dart';

@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState.goTo({
    required String route,
    Object? extra,
  }) = _NavigationState;

  const factory NavigationState.back() = _BackNavigationState;
}
