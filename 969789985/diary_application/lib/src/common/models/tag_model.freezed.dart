// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagModel {
  int get id => throw _privateConstructorUsedError;
  String get tagTitle => throw _privateConstructorUsedError;
  int get tagIcon => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, String tagTitle, int tagIcon) internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, String tagTitle, int tagIcon)? internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, String tagTitle, int tagIcon)? internal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TagModel value) internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TagModel value)? internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TagModel value)? internal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res, TagModel>;
  @useResult
  $Res call({int id, String tagTitle, int tagIcon});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res, $Val extends TagModel>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tagTitle = null,
    Object? tagIcon = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tagTitle: null == tagTitle
          ? _value.tagTitle
          : tagTitle // ignore: cast_nullable_to_non_nullable
              as String,
      tagIcon: null == tagIcon
          ? _value.tagIcon
          : tagIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TagModelCopyWith<$Res> implements $TagModelCopyWith<$Res> {
  factory _$$_TagModelCopyWith(
          _$_TagModel value, $Res Function(_$_TagModel) then) =
      __$$_TagModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String tagTitle, int tagIcon});
}

/// @nodoc
class __$$_TagModelCopyWithImpl<$Res>
    extends _$TagModelCopyWithImpl<$Res, _$_TagModel>
    implements _$$_TagModelCopyWith<$Res> {
  __$$_TagModelCopyWithImpl(
      _$_TagModel _value, $Res Function(_$_TagModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tagTitle = null,
    Object? tagIcon = null,
  }) {
    return _then(_$_TagModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tagTitle: null == tagTitle
          ? _value.tagTitle
          : tagTitle // ignore: cast_nullable_to_non_nullable
              as String,
      tagIcon: null == tagIcon
          ? _value.tagIcon
          : tagIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TagModel extends _TagModel {
  _$_TagModel({required this.id, required this.tagTitle, required this.tagIcon})
      : super._();

  @override
  final int id;
  @override
  final String tagTitle;
  @override
  final int tagIcon;

  @override
  String toString() {
    return 'TagModel.internal(id: $id, tagTitle: $tagTitle, tagIcon: $tagIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tagTitle, tagTitle) ||
                other.tagTitle == tagTitle) &&
            (identical(other.tagIcon, tagIcon) || other.tagIcon == tagIcon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, tagTitle, tagIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagModelCopyWith<_$_TagModel> get copyWith =>
      __$$_TagModelCopyWithImpl<_$_TagModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, String tagTitle, int tagIcon) internal,
  }) {
    return internal(id, tagTitle, tagIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, String tagTitle, int tagIcon)? internal,
  }) {
    return internal?.call(id, tagTitle, tagIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, String tagTitle, int tagIcon)? internal,
    required TResult orElse(),
  }) {
    if (internal != null) {
      return internal(id, tagTitle, tagIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TagModel value) internal,
  }) {
    return internal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TagModel value)? internal,
  }) {
    return internal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TagModel value)? internal,
    required TResult orElse(),
  }) {
    if (internal != null) {
      return internal(this);
    }
    return orElse();
  }
}

abstract class _TagModel extends TagModel {
  factory _TagModel(
      {required final int id,
      required final String tagTitle,
      required final int tagIcon}) = _$_TagModel;
  _TagModel._() : super._();

  @override
  int get id;
  @override
  String get tagTitle;
  @override
  int get tagIcon;
  @override
  @JsonKey(ignore: true)
  _$$_TagModelCopyWith<_$_TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}
