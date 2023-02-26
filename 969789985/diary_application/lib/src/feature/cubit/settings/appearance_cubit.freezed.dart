// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppearanceState {
  IMap<int, bool> get selectedTags => throw _privateConstructorUsedError;
  int get selectedIcon => throw _privateConstructorUsedError;
  String get tagText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppearanceStateCopyWith<AppearanceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppearanceStateCopyWith<$Res> {
  factory $AppearanceStateCopyWith(
          AppearanceState value, $Res Function(AppearanceState) then) =
      _$AppearanceStateCopyWithImpl<$Res, AppearanceState>;
  @useResult
  $Res call({IMap<int, bool> selectedTags, int selectedIcon, String tagText});
}

/// @nodoc
class _$AppearanceStateCopyWithImpl<$Res, $Val extends AppearanceState>
    implements $AppearanceStateCopyWith<$Res> {
  _$AppearanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTags = null,
    Object? selectedIcon = null,
    Object? tagText = null,
  }) {
    return _then(_value.copyWith(
      selectedTags: null == selectedTags
          ? _value.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
      selectedIcon: null == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as int,
      tagText: null == tagText
          ? _value.tagText
          : tagText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppearanceStateCopyWith<$Res>
    implements $AppearanceStateCopyWith<$Res> {
  factory _$$_AppearanceStateCopyWith(
          _$_AppearanceState value, $Res Function(_$_AppearanceState) then) =
      __$$_AppearanceStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IMap<int, bool> selectedTags, int selectedIcon, String tagText});
}

/// @nodoc
class __$$_AppearanceStateCopyWithImpl<$Res>
    extends _$AppearanceStateCopyWithImpl<$Res, _$_AppearanceState>
    implements _$$_AppearanceStateCopyWith<$Res> {
  __$$_AppearanceStateCopyWithImpl(
      _$_AppearanceState _value, $Res Function(_$_AppearanceState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTags = null,
    Object? selectedIcon = null,
    Object? tagText = null,
  }) {
    return _then(_$_AppearanceState(
      selectedTags: null == selectedTags
          ? _value.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
      selectedIcon: null == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as int,
      tagText: null == tagText
          ? _value.tagText
          : tagText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppearanceState implements _AppearanceState {
  const _$_AppearanceState(
      {required this.selectedTags,
      required this.selectedIcon,
      required this.tagText});

  @override
  final IMap<int, bool> selectedTags;
  @override
  final int selectedIcon;
  @override
  final String tagText;

  @override
  String toString() {
    return 'AppearanceState(selectedTags: $selectedTags, selectedIcon: $selectedIcon, tagText: $tagText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppearanceState &&
            (identical(other.selectedTags, selectedTags) ||
                other.selectedTags == selectedTags) &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.tagText, tagText) || other.tagText == tagText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedTags, selectedIcon, tagText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppearanceStateCopyWith<_$_AppearanceState> get copyWith =>
      __$$_AppearanceStateCopyWithImpl<_$_AppearanceState>(this, _$identity);
}

abstract class _AppearanceState implements AppearanceState {
  const factory _AppearanceState(
      {required final IMap<int, bool> selectedTags,
      required final int selectedIcon,
      required final String tagText}) = _$_AppearanceState;

  @override
  IMap<int, bool> get selectedTags;
  @override
  int get selectedIcon;
  @override
  String get tagText;
  @override
  @JsonKey(ignore: true)
  _$$_AppearanceStateCopyWith<_$_AppearanceState> get copyWith =>
      throw _privateConstructorUsedError;
}
