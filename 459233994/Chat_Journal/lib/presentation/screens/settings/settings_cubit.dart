import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/shared_preferences_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  SettingsCubit({required sharedPreferencesRepository})
      : _sharedPreferencesRepository = sharedPreferencesRepository,
        super(SettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final fontSize = await _sharedPreferencesRepository.loadFontPreferences();
    final isRightBubbleAlignment =
        await _sharedPreferencesRepository.loadBubbleAlignmentPreferences();
    final isCenterBubble =
        await _sharedPreferencesRepository.loadDateBubblePreferences();
    final backgroundImage =
        await _sharedPreferencesRepository.loadBackgroundImage();
    emit(
      state.copyWith(
        fontSize: fontSize,
        isRightBubbleAlignment: isRightBubbleAlignment,
        isCenterDateBubble: isCenterBubble,
        backgroundImage: backgroundImage,
      ),
    );
  }

  Future<void> changeFont(int fontSize) async {
    _sharedPreferencesRepository.updateFont(fontSize);
    emit(
      state.copyWith(
        fontSize: fontSize,
      ),
    );
  }

  Future<void> changeBubbleAlignment(bool isRightBubbleAlignment) async {
    _sharedPreferencesRepository.updateBubbleAlignment(isRightBubbleAlignment);
    emit(
      state.copyWith(
        isRightBubbleAlignment: isRightBubbleAlignment,
      ),
    );
  }

  Future<void> changeDateBubble(bool isCenterBubble) async {
    _sharedPreferencesRepository.updateDateBubble(isCenterBubble);
    emit(
      state.copyWith(
        isCenterDateBubble: isCenterBubble,
      ),
    );
  }

  Future<void> setBackGroundImage(String? backgroundImage) async {
    _sharedPreferencesRepository.updateBackgroundImage(backgroundImage);
    emit(
      state.copyWith(backgroundImage: backgroundImage),
    );
  }
}
