import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/default_values.dart';
import '../settings.dart';

part 'settings_state.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepositoryApi settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(
          SettingsState(
            fontScaleFactor: settingsRepository.fontScaleFactor,
            messageAlignment: settingsRepository.messageAlignment,
            isCenterDateBubbleShown: settingsRepository.isCenterDateBubbleShown,
            imagePath: settingsRepository.backgroundImagePath,
          ),
        );

  final SettingsRepositoryApi _settingsRepository;

  Future<void> changeFontSize(FontScaleFactor fontScaleFactor) async {
    emit(
      state.copyWith(
        fontScaleFactor: fontScaleFactor,
      ),
    );
    await _settingsRepository.setFontScaleFactor(fontScaleFactor);
  }

  Future<void> changeMessageAlignment(MessageAlignment messageAlignment) async {
    emit(
      state.copyWith(
        messageAlignment: messageAlignment,
      ),
    );
    await _settingsRepository.setMessageAlignment(messageAlignment);
  }

  Future<void> changeBubbleDateVisibility(bool isVisible) async {
    emit(
      state.copyWith(
        isCenterDateBubbleShown: isVisible,
      ),
    );
    await _settingsRepository.setCenterDateBubbleShown(isVisible);
  }

  Future<void> changeBackgroundImagePath(String? path) async {
    await _settingsRepository.setBackgroundImagePath(path);
    emit(
      state.copyWith(
        imagePath: _settingsRepository.backgroundImagePath,
      ),
    );
  }

  Future<void> resetToDefault() async {
    emit(
      SettingsState(
        fontScaleFactor: DefaultValues.fontScaleFactor,
        messageAlignment: DefaultValues.messageAlignment,
        isCenterDateBubbleShown: DefaultValues.isCenterDateBubbleShown,
      ),
    );
  }
}
