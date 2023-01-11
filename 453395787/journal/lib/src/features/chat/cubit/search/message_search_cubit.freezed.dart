// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String query, IList<Tag>? queryTags) loading,
    required TResult Function(String query, IList<Tag>? queryTags) empty,
    required TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)
        results,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String query, IList<Tag>? queryTags)? loading,
    TResult? Function(String query, IList<Tag>? queryTags)? empty,
    TResult? Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String query, IList<Tag>? queryTags)? loading,
    TResult Function(String query, IList<Tag>? queryTags)? empty,
    TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Result value) results,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Result value)? results,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_Result value)? results,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSearchStateCopyWith<$Res> {
  factory $MessageSearchStateCopyWith(
          MessageSearchState value, $Res Function(MessageSearchState) then) =
      _$MessageSearchStateCopyWithImpl<$Res, MessageSearchState>;
}

/// @nodoc
class _$MessageSearchStateCopyWithImpl<$Res, $Val extends MessageSearchState>
    implements $MessageSearchStateCopyWith<$Res> {
  _$MessageSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial() : super._();

  @override
  String toString() {
    return 'MessageSearchState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String query, IList<Tag>? queryTags) loading,
    required TResult Function(String query, IList<Tag>? queryTags) empty,
    required TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)
        results,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String query, IList<Tag>? queryTags)? loading,
    TResult? Function(String query, IList<Tag>? queryTags)? empty,
    TResult? Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String query, IList<Tag>? queryTags)? loading,
    TResult Function(String query, IList<Tag>? queryTags)? empty,
    TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Result value) results,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Result value)? results,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_Result value)? results,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends MessageSearchState {
  const factory _Initial() = _$_Initial;
  const _Initial._() : super._();
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, IList<Tag>? queryTags});
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? queryTags = freezed,
  }) {
    return _then(_$_Loading(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      queryTags: freezed == queryTags
          ? _value.queryTags
          : queryTags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>?,
    ));
  }
}

/// @nodoc

class _$_Loading extends _Loading {
  const _$_Loading({required this.query, this.queryTags}) : super._();

  @override
  final String query;
  @override
  final IList<Tag>? queryTags;

  @override
  String toString() {
    return 'MessageSearchState.loading(query: $query, queryTags: $queryTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loading &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other.queryTags, queryTags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, query, const DeepCollectionEquality().hash(queryTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      __$$_LoadingCopyWithImpl<_$_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String query, IList<Tag>? queryTags) loading,
    required TResult Function(String query, IList<Tag>? queryTags) empty,
    required TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)
        results,
  }) {
    return loading(query, queryTags);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String query, IList<Tag>? queryTags)? loading,
    TResult? Function(String query, IList<Tag>? queryTags)? empty,
    TResult? Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
  }) {
    return loading?.call(query, queryTags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String query, IList<Tag>? queryTags)? loading,
    TResult Function(String query, IList<Tag>? queryTags)? empty,
    TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(query, queryTags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Result value) results,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Result value)? results,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_Result value)? results,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends MessageSearchState {
  const factory _Loading(
      {required final String query, final IList<Tag>? queryTags}) = _$_Loading;
  const _Loading._() : super._();

  String get query;
  IList<Tag>? get queryTags;
  @JsonKey(ignore: true)
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EmptyCopyWith<$Res> {
  factory _$$_EmptyCopyWith(_$_Empty value, $Res Function(_$_Empty) then) =
      __$$_EmptyCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, IList<Tag>? queryTags});
}

/// @nodoc
class __$$_EmptyCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_Empty>
    implements _$$_EmptyCopyWith<$Res> {
  __$$_EmptyCopyWithImpl(_$_Empty _value, $Res Function(_$_Empty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? queryTags = freezed,
  }) {
    return _then(_$_Empty(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      queryTags: freezed == queryTags
          ? _value.queryTags
          : queryTags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>?,
    ));
  }
}

/// @nodoc

class _$_Empty extends _Empty {
  const _$_Empty({required this.query, this.queryTags}) : super._();

  @override
  final String query;
  @override
  final IList<Tag>? queryTags;

  @override
  String toString() {
    return 'MessageSearchState.empty(query: $query, queryTags: $queryTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Empty &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other.queryTags, queryTags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, query, const DeepCollectionEquality().hash(queryTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmptyCopyWith<_$_Empty> get copyWith =>
      __$$_EmptyCopyWithImpl<_$_Empty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String query, IList<Tag>? queryTags) loading,
    required TResult Function(String query, IList<Tag>? queryTags) empty,
    required TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)
        results,
  }) {
    return empty(query, queryTags);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String query, IList<Tag>? queryTags)? loading,
    TResult? Function(String query, IList<Tag>? queryTags)? empty,
    TResult? Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
  }) {
    return empty?.call(query, queryTags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String query, IList<Tag>? queryTags)? loading,
    TResult Function(String query, IList<Tag>? queryTags)? empty,
    TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(query, queryTags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Result value) results,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Result value)? results,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_Result value)? results,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty extends MessageSearchState {
  const factory _Empty(
      {required final String query, final IList<Tag>? queryTags}) = _$_Empty;
  const _Empty._() : super._();

  String get query;
  IList<Tag>? get queryTags;
  @JsonKey(ignore: true)
  _$$_EmptyCopyWith<_$_Empty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ResultCopyWith<$Res> {
  factory _$$_ResultCopyWith(_$_Result value, $Res Function(_$_Result) then) =
      __$$_ResultCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, IList<Tag>? queryTags, IList<Message> messages});
}

/// @nodoc
class __$$_ResultCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_Result>
    implements _$$_ResultCopyWith<$Res> {
  __$$_ResultCopyWithImpl(_$_Result _value, $Res Function(_$_Result) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? queryTags = freezed,
    Object? messages = null,
  }) {
    return _then(_$_Result(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      queryTags: freezed == queryTags
          ? _value.queryTags
          : queryTags // ignore: cast_nullable_to_non_nullable
              as IList<Tag>?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<Message>,
    ));
  }
}

/// @nodoc

class _$_Result extends _Result {
  const _$_Result({required this.query, this.queryTags, required this.messages})
      : super._();

  @override
  final String query;
  @override
  final IList<Tag>? queryTags;
  @override
  final IList<Message> messages;

  @override
  String toString() {
    return 'MessageSearchState.results(query: $query, queryTags: $queryTags, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Result &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other.queryTags, queryTags) &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      const DeepCollectionEquality().hash(queryTags),
      const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      __$$_ResultCopyWithImpl<_$_Result>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String query, IList<Tag>? queryTags) loading,
    required TResult Function(String query, IList<Tag>? queryTags) empty,
    required TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)
        results,
  }) {
    return results(query, queryTags, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String query, IList<Tag>? queryTags)? loading,
    TResult? Function(String query, IList<Tag>? queryTags)? empty,
    TResult? Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
  }) {
    return results?.call(query, queryTags, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String query, IList<Tag>? queryTags)? loading,
    TResult Function(String query, IList<Tag>? queryTags)? empty,
    TResult Function(
            String query, IList<Tag>? queryTags, IList<Message> messages)?
        results,
    required TResult orElse(),
  }) {
    if (results != null) {
      return results(query, queryTags, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Result value) results,
  }) {
    return results(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Result value)? results,
  }) {
    return results?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_Result value)? results,
    required TResult orElse(),
  }) {
    if (results != null) {
      return results(this);
    }
    return orElse();
  }
}

abstract class _Result extends MessageSearchState {
  const factory _Result(
      {required final String query,
      final IList<Tag>? queryTags,
      required final IList<Message> messages}) = _$_Result;
  const _Result._() : super._();

  String get query;
  IList<Tag>? get queryTags;
  IList<Message> get messages;
  @JsonKey(ignore: true)
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      throw _privateConstructorUsedError;
}
