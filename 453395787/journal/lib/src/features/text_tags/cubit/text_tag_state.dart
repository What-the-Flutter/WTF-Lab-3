part of 'text_tag_cubit.dart';

@freezed
class TextTagState with _$TextTagState {
  const factory TextTagState.initial() = _Initial;

  const factory TextTagState.success({
    required IList<TextTag> tags,
  }) = _Success;

  const factory TextTagState.addModeState({
    required TextTag tag,
  }) = _AddModeState;

  const factory TextTagState.selectedState({
    required TextTag tag,
  }) = _SelectedState;
}
