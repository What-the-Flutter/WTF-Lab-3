part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required FontScaleFactor fontScaleFactor,
    required MessageAlignment messageAlignment,
    required bool isCenterDateBubbleShown,
    String? imagePath,
  }) = _SettingsState;
}
