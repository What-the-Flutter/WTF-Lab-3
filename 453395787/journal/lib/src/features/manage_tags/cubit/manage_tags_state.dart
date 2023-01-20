part of 'manage_tags_cubit.dart';

@freezed
class ManageTagsState with _$ManageTagsState {
  const factory ManageTagsState.initial({
    required IList<Tag> tags,
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
    required IList<Tag> tags,
    required Id selectedTag,
  }) = _SelectModeState;
}
