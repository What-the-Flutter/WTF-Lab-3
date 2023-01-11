// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagsState {
  IList<Tag> get tags => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Tag> tags) initial,
    required TResult Function(IList<Tag> tags, IList<Tag> selected) hasSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Tag> tags)? initial,
    TResult? Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Tag> tags)? initial,
    TResult Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TagsInitialState value) initial,
    required TResult Function(TagsHasSelectedState value) hasSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TagsInitialState value)? initial,
    TResult? Function(TagsHasSelectedState value)? hasSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TagsInitialState value)? initial,
    TResult Function(TagsHasSelectedState value)? hasSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagsStateCopyWith<TagsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagsStateCopyWith<$Res> {
  factory $TagsStateCopyWith(TagsState value, $Res Function(TagsState) then) =
      _$TagsStateCopyWithImpl<$Res, TagsState>;
  @useResult
  $Res call({IList<Tag> tags});
}

/// @nodoc
class _$TagsStateCopyWithImpl<$Res, $Val extends TagsState>
    implements $TagsStateCopyWith<$Res> {
  _$TagsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagsInitialStateCopyWith<$Res>
    implements $TagsStateCopyWith<$Res> {
  factory _$$TagsInitialStateCopyWith(
          _$TagsInitialState value, $Res Function(_$TagsInitialState) then) =
      __$$TagsInitialStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Tag> tags});
}

/// @nodoc
class __$$TagsInitialStateCopyWithImpl<$Res>
    extends _$TagsStateCopyWithImpl<$Res, _$TagsInitialState>
    implements _$$TagsInitialStateCopyWith<$Res> {
  __$$TagsInitialStateCopyWithImpl(
      _$TagsInitialState _value, $Res Function(_$TagsInitialState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
  }) {
    return _then(_$TagsInitialState(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>,
    ));
  }
}

/// @nodoc

class _$TagsInitialState extends TagsInitialState {
  const _$TagsInitialState({required this.tags}) : super._();

  @override
  final IList<Tag> tags;

  @override
  String toString() {
    return 'TagsState.initial(tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsInitialState &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsInitialStateCopyWith<_$TagsInitialState> get copyWith =>
      __$$TagsInitialStateCopyWithImpl<_$TagsInitialState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Tag> tags) initial,
    required TResult Function(IList<Tag> tags, IList<Tag> selected) hasSelected,
  }) {
    return initial(tags);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Tag> tags)? initial,
    TResult? Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
  }) {
    return initial?.call(tags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Tag> tags)? initial,
    TResult Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(tags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TagsInitialState value) initial,
    required TResult Function(TagsHasSelectedState value) hasSelected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TagsInitialState value)? initial,
    TResult? Function(TagsHasSelectedState value)? hasSelected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TagsInitialState value)? initial,
    TResult Function(TagsHasSelectedState value)? hasSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TagsInitialState extends TagsState {
  const factory TagsInitialState({required final IList<Tag> tags}) =
      _$TagsInitialState;
  const TagsInitialState._() : super._();

  @override
  IList<Tag> get tags;
  @override
  @JsonKey(ignore: true)
  _$$TagsInitialStateCopyWith<_$TagsInitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TagsHasSelectedStateCopyWith<$Res>
    implements $TagsStateCopyWith<$Res> {
  factory _$$TagsHasSelectedStateCopyWith(_$TagsHasSelectedState value,
          $Res Function(_$TagsHasSelectedState) then) =
      __$$TagsHasSelectedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Tag> tags, IList<Tag> selected});
}

/// @nodoc
class __$$TagsHasSelectedStateCopyWithImpl<$Res>
    extends _$TagsStateCopyWithImpl<$Res, _$TagsHasSelectedState>
    implements _$$TagsHasSelectedStateCopyWith<$Res> {
  __$$TagsHasSelectedStateCopyWithImpl(_$TagsHasSelectedState _value,
      $Res Function(_$TagsHasSelectedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? selected = null,
  }) {
    return _then(_$TagsHasSelectedState(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as IList<Tag>,
    ));
  }
}

/// @nodoc

class _$TagsHasSelectedState extends TagsHasSelectedState {
  const _$TagsHasSelectedState({required this.tags, required this.selected})
      : super._();

  @override
  final IList<Tag> tags;
  @override
  final IList<Tag> selected;

  @override
  String toString() {
    return 'TagsState.hasSelected(tags: $tags, selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsHasSelectedState &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.selected, selected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(selected));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsHasSelectedStateCopyWith<_$TagsHasSelectedState> get copyWith =>
      __$$TagsHasSelectedStateCopyWithImpl<_$TagsHasSelectedState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Tag> tags) initial,
    required TResult Function(IList<Tag> tags, IList<Tag> selected) hasSelected,
  }) {
    return hasSelected(tags, selected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Tag> tags)? initial,
    TResult? Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
  }) {
    return hasSelected?.call(tags, selected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Tag> tags)? initial,
    TResult Function(IList<Tag> tags, IList<Tag> selected)? hasSelected,
    required TResult orElse(),
  }) {
    if (hasSelected != null) {
      return hasSelected(tags, selected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TagsInitialState value) initial,
    required TResult Function(TagsHasSelectedState value) hasSelected,
  }) {
    return hasSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TagsInitialState value)? initial,
    TResult? Function(TagsHasSelectedState value)? hasSelected,
  }) {
    return hasSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TagsInitialState value)? initial,
    TResult Function(TagsHasSelectedState value)? hasSelected,
    required TResult orElse(),
  }) {
    if (hasSelected != null) {
      return hasSelected(this);
    }
    return orElse();
  }
}

abstract class TagsHasSelectedState extends TagsState {
  const factory TagsHasSelectedState(
      {required final IList<Tag> tags,
      required final IList<Tag> selected}) = _$TagsHasSelectedState;
  const TagsHasSelectedState._() : super._();

  @override
  IList<Tag> get tags;
  IList<Tag> get selected;
  @override
  @JsonKey(ignore: true)
  _$$TagsHasSelectedStateCopyWith<_$TagsHasSelectedState> get copyWith =>
      throw _privateConstructorUsedError;
}
