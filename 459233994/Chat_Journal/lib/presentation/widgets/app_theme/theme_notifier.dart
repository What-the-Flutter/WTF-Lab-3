import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _keyDefaultMode = 'default_mode';
  bool isDefaultTheme = true;
  late CustomTheme _theme = CustomTheme(
    name: 'default',
    themeColor: const Color(0xffB1CC74),
    auxiliaryColor: const Color(0xffE8FCC2),
    keyColor: const Color(0xffffffff),
    backgroundColor: const Color(0xffffffff),
    textColor: const Color(0xff545F66),
    iconColor: const Color(0xff829399),
    actionColor: const Color(0xffD0F4EA),
  );


  Future<void> loadPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    isDefaultTheme = preferences.getBool(_keyDefaultMode) ?? true;
    print(preferences.getBool(_keyDefaultMode));
  }

  CustomTheme get theme => _theme;

  void getStartTheme(CustomTheme theme) async{
    final preferences = await SharedPreferences.getInstance();
    print(preferences.getBool(_keyDefaultMode));
    _theme = theme;
    notifyListeners();
  }

  void update(CustomTheme theme) async {
    final preferences = await SharedPreferences.getInstance();
    isDefaultTheme = !isDefaultTheme;
    _theme = theme;
    await preferences.setBool(_keyDefaultMode, isDefaultTheme);
    print(preferences.getBool(_keyDefaultMode));
    notifyListeners();
  }
}
