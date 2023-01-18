part of 'manage_tags_cubit.dart';

@freezed
class ManageTagsState with _$ManageTagsState {
  const factory ManageTagsState.initial({
    required TagList tags,
  }) = _Initial;

  const factory ManageTagsState.addModeState({
    required IList<Color> colors,
    required Tag newTag,
  }) = _AddModeState;

  const factory ManageTagsState.editModeState({
    required IList<Color> colors,
    required Tag editableTag,
  }) = _EditModeState;

  const factory ManageTagsState.selectModeState({
    required TagList tags,
    required int selectedTag,
  }) = _SelectModeState;
}
