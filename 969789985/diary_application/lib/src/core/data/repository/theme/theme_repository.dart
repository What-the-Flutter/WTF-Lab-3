import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repository/theme/api_theme_repository.dart';
import '../../../util/resources/dimensions.dart';
import '../../../util/resources/strings.dart';
import '../../../util/resources/themes.dart';

enum BubbleAlignments {
  start(MessageAlignment.start),
  center(MessageAlignment.center),
  end(MessageAlignment.end);

  final String alignment;

  const BubbleAlignments(this.alignment);
}

class ThemeRepository implements ApiThemeRepository {
  static const String mainKeyDesc = 'com.wtflab.diary_application_';

  static const String _isDarkModeKey = '${mainKeyDesc}theme_mode_key';
  static const String _messageFontSizeKey = '${mainKeyDesc}message_font_size';
  static const String _messageBorderRadiusKey =
      '${mainKeyDesc}message_border_radius';
  static const String _primaryColorKey = '${mainKeyDesc}primary_color';
  static const String _primaryItemColorKey = ''
      '${mainKeyDesc}primary_item_color';
  static const String _messageAlignmentKey = '${mainKeyDesc}message_alignment';
  static const String _dateBubbleVisibleKey =
      '${mainKeyDesc}date_bubble_visible';
  static const String _chatBackgroundColorKey =
      '${mainKeyDesc}chat_background_color';
  static const String _imagePathKey = '${mainKeyDesc}image_path';

  static bool _isDarkMode = false;

  static double _messageFontSize = 14.0;

  static double _messageBorderRadius = Radii.appConstantExtraLarge;

  static int _primaryColor = LightPossibleColors.main.colors[0];

  static int _primaryItemColor = LightPossibleColors.main.colors[1];

  static String _messageAlignment = BubbleAlignments.end.alignment;

  static bool _dateBubbleVisible = true;

  static String _imagePath = '';

  static int _chatBackgroundColor = _isDarkMode
      ? AppColors.primaryBackgroundDark
      : AppColors.primaryBackgroundLight;

  static Future<void> initialize() async {
    final preference = await SharedPreferences.getInstance();

    _isDarkMode = await preference.getBool(_isDarkModeKey) ?? false;

    _messageFontSize = await preference.getDouble(_messageFontSizeKey) ?? 14.0;

    _messageBorderRadius =
        await preference.getDouble(_messageBorderRadiusKey) ??
            Radii.appConstantExtraLarge;

    _primaryColor = await preference.getInt(_primaryColorKey) ??
        LightPossibleColors.main.colors[0];
    _primaryItemColor = await preference.getInt(_primaryItemColorKey) ??
        LightPossibleColors.main.colors[1];

    _messageAlignment = await preference.getString(_messageAlignmentKey) ??
        BubbleAlignments.end.alignment;

    _dateBubbleVisible =
        await preference.getBool(_dateBubbleVisibleKey) ?? false;

    _chatBackgroundColor = await preference.getInt(_chatBackgroundColorKey) ??
        _chatBackgroundColor;

    _imagePath = await preference.getString(_imagePathKey) ?? '';
  }

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  double get messageFontSize => _messageFontSize;

  @override
  double get messageBorderRadius => _messageBorderRadius;

  @override
  int get primaryColor => _primaryColor;

  @override
  int get primaryItemColor => _primaryItemColor;

  @override
  String get messageAlignment => _messageAlignment;

  @override
  bool get dateBubbleVisible => _dateBubbleVisible;

  @override
  int get chatBackgroundColor => _chatBackgroundColor;

  @override
  String get imagePath => _imagePath;

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isDarkModeKey, isDarkMode);
  }

  @override
  Future<void> setMessageFontSize(double fontSize) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(_messageFontSizeKey, fontSize);
  }

  @override
  Future<void> setMessageBorderRadius(double radius) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(_messageBorderRadiusKey, radius);
  }

  @override
  Future<void> setColors(int primaryColor, int primaryItemColor) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_primaryColorKey, primaryColor);
    await preferences.setInt(_primaryItemColorKey, primaryItemColor);
  }

  @override
  Future<void> setMessageAlignment(String alignment) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_messageAlignmentKey, alignment);
  }

  @override
  Future<void> setDateBubbleVisible(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_dateBubbleVisibleKey, value);
  }

  @override
  Future<void> setChatBackgroundColor(int color) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_chatBackgroundColorKey, color);
  }

  @override
  Future<void> setImagePath(String path) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_imagePathKey, path);
  }
}
