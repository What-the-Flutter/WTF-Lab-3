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
          ),
        );

  final SettingsRepositoryApi _settingsRepository;

  void changeFontSize(FontSize fontSize) {
    emit(state.copyWith(
      fontSize: fontSize,
    ));
  }
}
