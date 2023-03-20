import 'package:flutter/material.dart';

class CustomTheme {
  final String _name;
  final Color _themeColor;
  final Color _auxiliaryColor;
  final Color _keyColor;
  final Color _backgroundColor;
  final Color _textColor;
  final Color _iconColor;
  final Color _actionColor;

  CustomTheme({
    required name,
    required themeColor,
    required auxiliaryColor,
    required keyColor,
    required backgroundColor,
    required textColor,
    required iconColor,
    required actionColor,
  })  : _name = name,
        _themeColor = themeColor,
        _auxiliaryColor = auxiliaryColor,
        _keyColor = keyColor,
        _backgroundColor = backgroundColor,
        _textColor = textColor,
        _iconColor = iconColor,
        _actionColor = actionColor;

  String get name => _name;

  Color get themeColor => _themeColor;

  Color get auxiliaryColor => _auxiliaryColor;

  Color get keyColor => _keyColor;

  Color get backgroundColor => _backgroundColor;

  Color get textColor => _textColor;

  Color get iconColor => _iconColor;

  Color get actionColor => _actionColor;
}
