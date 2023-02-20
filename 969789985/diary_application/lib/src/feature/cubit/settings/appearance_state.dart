part of 'appearance_cubit.dart';

@freezed
class AppearanceState with _$AppearanceState {
  const factory AppearanceState({
    required IMap<int, bool> selectedTags,
    required int selectedIcon,
    required String tagText,
  }) = _AppearanceState;
}
