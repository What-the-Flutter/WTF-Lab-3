import 'package:flutter/material.dart';

import '../../../data/services/shared_preferences.dart';
import 'theme.dart';

class AppThemeState {
  final CustomTheme customTheme;
  final bool isDefaultTheme;
  final SharedPreferencesService sharedPreferencesService;
  static final CustomTheme lightTheme = CustomTheme(
    name: 'default',
    themeColor: const Color(0xffB1CC74),
    auxiliaryColor: const Color(0xffE8FCC2),
    keyColor: const Color(0xffffffff),
    backgroundColor: const Color(0xffffffff),
    textColor: const Color(0xff545F66),
    iconColor: const Color(0xff829399),
    actionColor: const Color(0xffD0F4EA),
    contrastColor: const Color(0xFFFEC260),
  );
  static final CustomTheme blackTheme = CustomTheme(
    name: 'black',
    themeColor: const Color(0xff000000),
    auxiliaryColor: const Color(0xff7F8487),
    keyColor: const Color(0xffffffff),
    backgroundColor: const Color(0xff0F0E0E),
    textColor: const Color(0xffffffff),
    iconColor: const Color(0xffffffff),
    actionColor: const Color(0xff1E5128),
    contrastColor: const Color(0xFFFEC260),
  );

  AppThemeState({
    customTheme,
    isDefaultTheme,
    required this.sharedPreferencesService,
  })  : customTheme = customTheme ?? lightTheme,
        isDefaultTheme = isDefaultTheme ?? true;

  AppThemeState copyWith({
    CustomTheme? customTheme,
    bool? isDefaultTheme,
  }) {
    return AppThemeState(
      customTheme: customTheme ?? this.customTheme,
      isDefaultTheme: isDefaultTheme ?? this.isDefaultTheme,
      sharedPreferencesService: sharedPreferencesService,
    );
  }

  Future<AppThemeState> loadTheme() async {
    final isDefaultTheme =
        await sharedPreferencesService.loadThemePreferences();
    final theme = !isDefaultTheme ? blackTheme : lightTheme;
    return copyWith(
      isDefaultTheme: isDefaultTheme,
      customTheme: theme,
    );
  }

  AppThemeState changeTheme() {
    final theme = isDefaultTheme ? blackTheme : lightTheme;
    sharedPreferencesService.updateTheme(!isDefaultTheme);
    return copyWith(
      isDefaultTheme: !isDefaultTheme,
      customTheme: theme,
    );
  }
}
