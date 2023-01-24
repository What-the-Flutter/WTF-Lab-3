import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/default_values.dart';
import 'settings_repository_api.dart';

class SettingsRepository extends SettingsRepositoryApi {
  static final String _fontSizeKey = 'fontSizeKey';
  static final String _isCenterDateBubbleShownKey =
      'isCenterDateBubbleShownKey';
  static final String _messageAlignmentKey = 'messageAlignmentKey';

  static FontSize _fontSize = FontSize.medium;
  static bool _isCenterDateBubbleShown = true;
  static MessageAlignment _messageAlignment = MessageAlignment.right;

  static Future<void> init() async {
    await _initFontSizeProperty();
    await _initIsCenterDateBubbleShownProperty();
    await _initMessageAlignmentProperty();
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

  @override
  FontSize get fontSize => _fontSize;

  @override
  Future<void> setFontSize(FontSize fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontSizeKey, fontSize.name);
    _fontSize = fontSize;
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
  MessageAlignment get messageAlignment => _messageAlignment;

  @override
  Future<void> setMessageAlignment(MessageAlignment messageAlignment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_messageAlignmentKey, messageAlignment.name);
    _messageAlignment = messageAlignment;
  }

  @override
  Future<void> resetToDefault() async {
    await setFontSize(DefaultValues.fontSize);
    await setMessageAlignment(DefaultValues.messageAlignment);
    await setCenterDateBubbleShown(DefaultValues.isCenterDateBubbleShown);
  }
}
