// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseTagModel _$FirebaseTagModelFromJson(Map<String, dynamic> json) {
  return _FirebaseTagModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseTagModel {
  String get id => throw _privateConstructorUsedError;
  String get tagTitle => throw _privateConstructorUsedError;
  int get tagIcon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseTagModelCopyWith<FirebaseTagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseTagModelCopyWith<$Res> {
  factory $FirebaseTagModelCopyWith(
          FirebaseTagModel value, $Res Function(FirebaseTagModel) then) =
      _$FirebaseTagModelCopyWithImpl<$Res, FirebaseTagModel>;
  @useResult
  $Res call({String id, String tagTitle, int tagIcon});
}

/// @nodoc
class _$FirebaseTagModelCopyWithImpl<$Res, $Val extends FirebaseTagModel>
    implements $FirebaseTagModelCopyWith<$Res> {
  _$FirebaseTagModelCopyWithImpl(this._value, this._then);

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
              as String,
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
abstract class _$$_FirebaseTagModelCopyWith<$Res>
    implements $FirebaseTagModelCopyWith<$Res> {
  factory _$$_FirebaseTagModelCopyWith(
          _$_FirebaseTagModel value, $Res Function(_$_FirebaseTagModel) then) =
      __$$_FirebaseTagModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String tagTitle, int tagIcon});
}

/// @nodoc
class __$$_FirebaseTagModelCopyWithImpl<$Res>
    extends _$FirebaseTagModelCopyWithImpl<$Res, _$_FirebaseTagModel>
    implements _$$_FirebaseTagModelCopyWith<$Res> {
  __$$_FirebaseTagModelCopyWithImpl(
      _$_FirebaseTagModel _value, $Res Function(_$_FirebaseTagModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tagTitle = null,
    Object? tagIcon = null,
  }) {
    return _then(_$_FirebaseTagModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
@JsonSerializable()
class _$_FirebaseTagModel implements _FirebaseTagModel {
  const _$_FirebaseTagModel(
      {this.id = '_id', this.tagTitle = '_tag_title', this.tagIcon = 0});

  factory _$_FirebaseTagModel.fromJson(Map<String, dynamic> json) =>
      _$$_FirebaseTagModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String tagTitle;
  @override
  @JsonKey()
  final int tagIcon;

  @override
  String toString() {
    return 'FirebaseTagModel(id: $id, tagTitle: $tagTitle, tagIcon: $tagIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseTagModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tagTitle, tagTitle) ||
                other.tagTitle == tagTitle) &&
            (identical(other.tagIcon, tagIcon) || other.tagIcon == tagIcon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, tagTitle, tagIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirebaseTagModelCopyWith<_$_FirebaseTagModel> get copyWith =>
      __$$_FirebaseTagModelCopyWithImpl<_$_FirebaseTagModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirebaseTagModelToJson(
      this,
    );
  }
}

abstract class _FirebaseTagModel implements FirebaseTagModel {
  const factory _FirebaseTagModel(
      {final String id,
      final String tagTitle,
      final int tagIcon}) = _$_FirebaseTagModel;

  factory _FirebaseTagModel.fromJson(Map<String, dynamic> json) =
      _$_FirebaseTagModel.fromJson;

  @override
  String get id;
  @override
  String get tagTitle;
  @override
  int get tagIcon;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseTagModelCopyWith<_$_FirebaseTagModel> get copyWith =>
      throw _privateConstructorUsedError;
}
