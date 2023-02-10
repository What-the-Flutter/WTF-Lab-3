import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

class ThemeNotifier extends ChangeNotifier{
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

  CustomTheme get theme => _theme;

  void update(CustomTheme theme){
    _theme = theme;
    print(hasListeners);
    notifyListeners();
  }

  // final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  //   return ThemeNotifier();
  // });
}