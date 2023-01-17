part of 'manage_tags_cubit.dart';

@freezed
class ManageTagsState with _$ManageTagsState {
  const factory ManageTagsState.initial({
    required TagList tags,
  }) = _Initial;

  const factory ManageTagsState.addingMode({
    required IList<Color> colors,
    required Tag newTag,
  }) = _AddingMode;

  const factory ManageTagsState.editingMode({
    required IList<Color> colors,
    required Tag editableTag,
  }) = _EditingMode;

  const factory ManageTagsState.selectionMode({
    required TagList tags,
    required int selectedTag,
  }) = _SelectionMode;
}
