part of 'start_screen_cubit.dart';

@freezed
class StartScreenState with _$StartScreenState {
  const factory StartScreenState({
    required int pageIndex,
    required bool fabVisible,
    required bool gNavVisible,
    required String hashtag,
  }) = _StartScreenState;
}
