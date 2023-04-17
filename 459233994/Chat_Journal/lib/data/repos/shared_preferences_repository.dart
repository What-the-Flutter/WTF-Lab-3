import '../services/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferencesService _sharedPreferencesService;

  SharedPreferencesRepository({required sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService;

  Future<bool> loadThemePreferences() async {
    return _sharedPreferencesService.loadThemePreferences();
  }

  Future<int> loadFontPreferences() async {
    return _sharedPreferencesService.loadFontPreferences();
  }

  Future<bool> loadBubbleAlignmentPreferences() async {
    return _sharedPreferencesService.loadBubbleAlignmentPreferences();
  }

  Future<bool> loadDateBubblePreferences() async {
    return _sharedPreferencesService.loadDateBubblePreferences();
  }

  Future<String?> loadBackgroundImage() async {
    return _sharedPreferencesService.loadBackgroundImage();
  }

  Future<void> updateTheme(bool isDefaultTheme) async {
    _sharedPreferencesService.updateTheme(isDefaultTheme);
  }

  Future<void> updateFont(int fontSize) async {
    _sharedPreferencesService.updateFont(fontSize);
  }

  Future<void> updateBubbleAlignment(bool isRightSide) async {
    _sharedPreferencesService.updateBubbleAlignment(isRightSide);
  }

  Future<void> updateDateBubble(bool isCenterBubble) async {
    _sharedPreferencesService.updateDateBubble(isCenterBubble);
  }

  Future<void> updateBackgroundImage(String? backgroundImage) async {
    _sharedPreferencesService.updateBackgroundImage(backgroundImage);
  }
}
