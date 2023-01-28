import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/default_values.dart';
import 'settings_repository_api.dart';

class SettingsRepository extends SettingsRepositoryApi {
  static final String _fontSizeKey = 'fontSizeKey';
  static final String _isCenterDateBubbleShownKey =
      'isCenterDateBubbleShownKey';
  static final String _messageAlignmentKey = 'messageAlignmentKey';
  static final String _imagePathKey = 'imagePathKey';

  static FontSize _fontSize = FontSize.medium;
  static bool _isCenterDateBubbleShown = true;
  static MessageAlignment _messageAlignment = MessageAlignment.right;
  static String? _imagePath;

  static Future<void> init() async {
    await _initFontSizeProperty();
    await _initIsCenterDateBubbleShownProperty();
    await _initMessageAlignmentProperty();
    await _initImagePathProperty();
  }

  static Future<void> _initFontSizeProperty() async {
    final prefs = await SharedPreferences.getInstance();
    final fontSizeName = prefs.getString(_fontSizeKey);
    if (fontSizeName != null) {
      _fontSize = FontSize.values.byName(fontSizeName);
    }
  }

  static Future<void> _initIsCenterDateBubbleShownProperty() async {
    final prefs = await SharedPreferences.getInstance();
    final isCenterDateBubbleShown = prefs.getBool(_isCenterDateBubbleShownKey);
    if (isCenterDateBubbleShown != null) {
      _isCenterDateBubbleShown = isCenterDateBubbleShown;
    }
  }

  static Future<void> _initMessageAlignmentProperty() async {
    final prefs = await SharedPreferences.getInstance();
    final messageAlignmentName = prefs.getString(_messageAlignmentKey);
    if (messageAlignmentName != null) {
      _messageAlignment = MessageAlignment.values.byName(messageAlignmentName);
    }
  }

  static Future<void> _initImagePathProperty() async {
    final prefs = await SharedPreferences.getInstance();
    _imagePath = prefs.getString(_imagePathKey);
  }

  @override
  FontSize get fontSize => _fontSize;

  @override
  Future<void> setFontSize(FontSize fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontSizeKey, fontSize.name);
    _fontSize = fontSize;
  }

  @override
  MessageAlignment get messageAlignment => _messageAlignment;

  @override
  Future<void> setMessageAlignment(MessageAlignment messageAlignment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_messageAlignmentKey, messageAlignment.name);
    _messageAlignment = messageAlignment;
  }

  @override
  bool get isCenterDateBubbleShown => _isCenterDateBubbleShown;

  @override
  Future<void> setCenterDateBubbleShown(bool isCenterDateBubbleShown) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isCenterDateBubbleShownKey, isCenterDateBubbleShown);
    _isCenterDateBubbleShown = isCenterDateBubbleShown;
  }

  @override
  String? get backgroundImagePath => _imagePath;

  @override
  Future<void> setBackgroundImagePath(String? imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();

    if (imagePath != null) {
      final filename = basename(imagePath);
      final path = join(directory.path, filename);

      await File(imagePath).copy(path);
      await prefs.setString(_imagePathKey, path);

      _imagePath = path;
    } else {
      await prefs.remove(_imagePathKey);

      if (_imagePath != null) {
        final filename = basename(_imagePath!);
        await File(join(directory.path, filename)).delete();
      }

      _imagePath = null;
    }
  }

  @override
  Future<void> resetToDefault() async {
    await setFontSize(DefaultValues.fontSize);
    await setMessageAlignment(DefaultValues.messageAlignment);
    await setCenterDateBubbleShown(DefaultValues.isCenterDateBubbleShown);
  }
}
