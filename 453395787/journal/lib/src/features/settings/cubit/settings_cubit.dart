import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/settings_repository_api.dart';

part 'settings_state.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepositoryApi settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(
          SettingsState(
            fontSize: settingsRepository.fontSize,
            messageAlignment: settingsRepository.messageAlignment,
            isCenterDateBubbleShown: settingsRepository.isCenterDateBubbleShown,
          ),
        );

  final SettingsRepositoryApi _settingsRepository;

  Future<void> changeFontSize(FontSize fontSize) async {
    emit(state.copyWith(
      fontSize: fontSize,
    ));
    await _settingsRepository.setFontSize(fontSize);
  }

  Future<void> changeBubbleDateVisibility(bool isVisible) async {
    emit(
      state.copyWith(
        isCenterDateBubbleShown: isVisible,
      ),
    );
    await _settingsRepository.setCenterDateBubbleShown(isVisible);
  }

  Future<void> changeMessageAlignment(MessageAlignment messageAlignment) async {
    emit(
      state.copyWith(
        messageAlignment: messageAlignment,
      ),
    );
    await _settingsRepository.setMessageAlignment(messageAlignment);
  }
}
