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
  IList<MessageModel> get messages => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages) defaultMode,
    required TResult Function(IList<MessageModel> messages, String query)
        searchActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages)? defaultMode,
    TResult? Function(IList<MessageModel> messages, String query)? searchActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages)? defaultMode,
    TResult Function(IList<MessageModel> messages, String query)? searchActive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_SearchActive value) searchActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_SearchActive value)? searchActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_SearchActive value)? searchActive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageSearchStateCopyWith<MessageSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSearchStateCopyWith<$Res> {
  factory $MessageSearchStateCopyWith(
          MessageSearchState value, $Res Function(MessageSearchState) then) =
      _$MessageSearchStateCopyWithImpl<$Res, MessageSearchState>;
  @useResult
  $Res call({IList<MessageModel> messages});
}

/// @nodoc
class _$MessageSearchStateCopyWithImpl<$Res, $Val extends MessageSearchState>
    implements $MessageSearchStateCopyWith<$Res> {
  _$MessageSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DefaultModeCopyWith<$Res>
    implements $MessageSearchStateCopyWith<$Res> {
  factory _$$_DefaultModeCopyWith(
          _$_DefaultMode value, $Res Function(_$_DefaultMode) then) =
      __$$_DefaultModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<MessageModel> messages});
}

/// @nodoc
class __$$_DefaultModeCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_DefaultMode>
    implements _$$_DefaultModeCopyWith<$Res> {
  __$$_DefaultModeCopyWithImpl(
      _$_DefaultMode _value, $Res Function(_$_DefaultMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$_DefaultMode(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
    ));
  }
}

/// @nodoc

class _$_DefaultMode extends _DefaultMode {
  const _$_DefaultMode({required this.messages}) : super._();

  @override
  final IList<MessageModel> messages;

  @override
  String toString() {
    return 'MessageSearchState.defaultMode(messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages) defaultMode,
    required TResult Function(IList<MessageModel> messages, String query)
        searchActive,
  }) {
    return defaultMode(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages)? defaultMode,
    TResult? Function(IList<MessageModel> messages, String query)? searchActive,
  }) {
    return defaultMode?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages)? defaultMode,
    TResult Function(IList<MessageModel> messages, String query)? searchActive,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_SearchActive value) searchActive,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_SearchActive value)? searchActive,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_SearchActive value)? searchActive,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class _DefaultMode extends MessageSearchState {
  const factory _DefaultMode({required final IList<MessageModel> messages}) =
      _$_DefaultMode;
  const _DefaultMode._() : super._();

  @override
  IList<MessageModel> get messages;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SearchActiveCopyWith<$Res>
    implements $MessageSearchStateCopyWith<$Res> {
  factory _$$_SearchActiveCopyWith(
          _$_SearchActive value, $Res Function(_$_SearchActive) then) =
      __$$_SearchActiveCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<MessageModel> messages, String query});
}

/// @nodoc
class __$$_SearchActiveCopyWithImpl<$Res>
    extends _$MessageSearchStateCopyWithImpl<$Res, _$_SearchActive>
    implements _$$_SearchActiveCopyWith<$Res> {
  __$$_SearchActiveCopyWithImpl(
      _$_SearchActive _value, $Res Function(_$_SearchActive) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? query = null,
  }) {
    return _then(_$_SearchActive(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SearchActive extends _SearchActive {
  const _$_SearchActive({required this.messages, required this.query})
      : super._();

  @override
  final IList<MessageModel> messages;
  @override
  final String query;

  @override
  String toString() {
    return 'MessageSearchState.searchActive(messages: $messages, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchActive &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(messages), query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchActiveCopyWith<_$_SearchActive> get copyWith =>
      __$$_SearchActiveCopyWithImpl<_$_SearchActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages) defaultMode,
    required TResult Function(IList<MessageModel> messages, String query)
        searchActive,
  }) {
    return searchActive(messages, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages)? defaultMode,
    TResult? Function(IList<MessageModel> messages, String query)? searchActive,
  }) {
    return searchActive?.call(messages, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages)? defaultMode,
    TResult Function(IList<MessageModel> messages, String query)? searchActive,
    required TResult orElse(),
  }) {
    if (searchActive != null) {
      return searchActive(messages, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_SearchActive value) searchActive,
  }) {
    return searchActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_SearchActive value)? searchActive,
  }) {
    return searchActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_SearchActive value)? searchActive,
    required TResult orElse(),
  }) {
    if (searchActive != null) {
      return searchActive(this);
    }
    return orElse();
  }
}

abstract class _SearchActive extends MessageSearchState {
  const factory _SearchActive(
      {required final IList<MessageModel> messages,
      required final String query}) = _$_SearchActive;
  const _SearchActive._() : super._();

  @override
  IList<MessageModel> get messages;
  String get query;
  @override
  @JsonKey(ignore: true)
  _$$_SearchActiveCopyWith<_$_SearchActive> get copyWith =>
      throw _privateConstructorUsedError;
}
