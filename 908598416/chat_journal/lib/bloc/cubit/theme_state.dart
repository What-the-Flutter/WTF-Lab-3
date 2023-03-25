part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  final ThemeData theme;

  ThemeState({required this.theme});
}

class ThemeInitial extends ThemeState {
  ThemeInitial({required super.theme});
}
