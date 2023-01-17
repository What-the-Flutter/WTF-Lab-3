part of 'locale_cubit.dart';

@freezed
class LocaleState with _$LocaleState{
  const factory LocaleState.system([
    Locale? locale,
  ]) = _System;

  const factory LocaleState.custom({
    required Locale locale,
  }) = _Custom;
}
