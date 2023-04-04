import '../services/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferencesService sharedPreferencesService;

  SharedPreferencesRepository({required this.sharedPreferencesService});

  Future<bool> loadThemePreferences() async {
    return sharedPreferencesService.loadThemePreferences();
  }

  Future<int> loadFontPreferences() async {
    return sharedPreferencesService.loadFontPreferences();
  }

  Future<bool> loadBubbleAlignmentPreferences() async {
    return sharedPreferencesService.loadBubbleAlignmentPreferences();
  }

  Future<bool> loadDateBubblePreferences() async {
    return sharedPreferencesService.loadDateBubblePreferences();
  }

  Future<String?> loadBackgroundImage() async {
    return sharedPreferencesService.loadBackgroundImage();
  }

  Future<void> updateTheme(bool isDefaultTheme) async {
    sharedPreferencesService.updateTheme(isDefaultTheme);
  }

  Future<void> updateFont(int fontSize) async {
    sharedPreferencesService.updateFont(fontSize);
  }

  Future<void> updateBubbleAlignment(bool isRightSide) async {
    sharedPreferencesService.updateBubbleAlignment(isRightSide);
  }

  Future<void> updateDateBubble(bool isCenterBubble) async {
    sharedPreferencesService.updateDateBubble(isCenterBubble);
  }

  Future<void> updateBackgroundImage(String? backgroundImage) async {
    sharedPreferencesService.updateBackgroundImage(backgroundImage);
  }
}