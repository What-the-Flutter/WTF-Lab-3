part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.color,
    required this.isDarkMode,
  });

  final Color color;
  final bool isDarkMode;

  ThemeState copyWith({
    Color? color,
    bool? isDarkMode,
  }) {
    return ThemeState(
      color: color ?? this.color,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [
        color,
        isDarkMode,
      ];
}
