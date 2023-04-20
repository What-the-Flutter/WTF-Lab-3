import 'package:flutter/material.dart';

class CustomTheme {
  final String name;
  final Color themeColor;
  final Color auxiliaryColor;
  final Color keyColor;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color actionColor;
  final Color contrastColor;

  CustomTheme({
    required this.name,
    required this.themeColor,
    required this.auxiliaryColor,
    required this.keyColor,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.actionColor,
    required this.contrastColor,
  });

  static CustomTheme get lightTheme => CustomTheme(
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

  static CustomTheme get darkTheme => CustomTheme(
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
}
