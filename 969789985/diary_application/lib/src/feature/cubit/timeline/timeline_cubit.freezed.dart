// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimelineState {
  IList<MessageModel> get messages => throw _privateConstructorUsedError;
  IList<ChatModel> get chats => throw _privateConstructorUsedError;
  IList<TagModel> get tags => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages,
            IList<ChatModel> chats, IList<TagModel> tags, bool isFiltered)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)
        filterMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_FilterMode value) filterMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_FilterMode value)? filterMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_FilterMode value)? filterMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimelineStateCopyWith<TimelineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStateCopyWith<$Res> {
  factory $TimelineStateCopyWith(
          TimelineState value, $Res Function(TimelineState) then) =
      _$TimelineStateCopyWithImpl<$Res, TimelineState>;
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IList<ChatModel> chats,
      IList<TagModel> tags});
}

/// @nodoc
class _$TimelineStateCopyWithImpl<$Res, $Val extends TimelineState>
    implements $TimelineStateCopyWith<$Res> {
  _$TimelineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? chats = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DefaultModeCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$_DefaultModeCopyWith(
          _$_DefaultMode value, $Res Function(_$_DefaultMode) then) =
      __$$_DefaultModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IList<ChatModel> chats,
      IList<TagModel> tags,
      bool isFiltered});
}

/// @nodoc
class __$$_DefaultModeCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$_DefaultMode>
    implements _$$_DefaultModeCopyWith<$Res> {
  __$$_DefaultModeCopyWithImpl(
      _$_DefaultMode _value, $Res Function(_$_DefaultMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? chats = null,
    Object? tags = null,
    Object? isFiltered = null,
  }) {
    return _then(_$_DefaultMode(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
      isFiltered: null == isFiltered
          ? _value.isFiltered
          : isFiltered // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DefaultMode with DiagnosticableTreeMixin implements _DefaultMode {
  const _$_DefaultMode(
      {required this.messages,
      required this.chats,
      required this.tags,
      required this.isFiltered});

  @override
  final IList<MessageModel> messages;
  @override
  final IList<ChatModel> chats;
  @override
  final IList<TagModel> tags;
  @override
  final bool isFiltered;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimelineState.defaultMode(messages: $messages, chats: $chats, tags: $tags, isFiltered: $isFiltered)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimelineState.defaultMode'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('chats', chats))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('isFiltered', isFiltered));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.isFiltered, isFiltered) ||
                other.isFiltered == isFiltered));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(chats),
      const DeepCollectionEquality().hash(tags),
      isFiltered);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages,
            IList<ChatModel> chats, IList<TagModel> tags, bool isFiltered)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)
        filterMode,
  }) {
    return defaultMode(messages, chats, tags, isFiltered);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
  }) {
    return defaultMode?.call(messages, chats, tags, isFiltered);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(messages, chats, tags, isFiltered);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_FilterMode value) filterMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_FilterMode value)? filterMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_FilterMode value)? filterMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class _DefaultMode implements TimelineState {
  const factory _DefaultMode(
      {required final IList<MessageModel> messages,
      required final IList<ChatModel> chats,
      required final IList<TagModel> tags,
      required final bool isFiltered}) = _$_DefaultMode;

  @override
  IList<MessageModel> get messages;
  @override
  IList<ChatModel> get chats;
  @override
  IList<TagModel> get tags;
  bool get isFiltered;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FilterModeCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$_FilterModeCopyWith(
          _$_FilterMode value, $Res Function(_$_FilterMode) then) =
      __$$_FilterModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IList<ChatModel> chats,
      IList<TagModel> tags,
      int filterWay,
      String searchQuery,
      ISet<String> tagIds,
      ISet<String> chatIds,
      String dateFilter,
      bool imagesOnly,
      bool audioOnly,
      bool strongTagFilter,
      bool resultExist});
}

/// @nodoc
class __$$_FilterModeCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$_FilterMode>
    implements _$$_FilterModeCopyWith<$Res> {
  __$$_FilterModeCopyWithImpl(
      _$_FilterMode _value, $Res Function(_$_FilterMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? chats = null,
    Object? tags = null,
    Object? filterWay = null,
    Object? searchQuery = null,
    Object? tagIds = null,
    Object? chatIds = null,
    Object? dateFilter = null,
    Object? imagesOnly = null,
    Object? audioOnly = null,
    Object? strongTagFilter = null,
    Object? resultExist = null,
  }) {
    return _then(_$_FilterMode(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
      filterWay: null == filterWay
          ? _value.filterWay
          : filterWay // ignore: cast_nullable_to_non_nullable
              as int,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      tagIds: null == tagIds
          ? _value.tagIds
          : tagIds // ignore: cast_nullable_to_non_nullable
              as ISet<String>,
      chatIds: null == chatIds
          ? _value.chatIds
          : chatIds // ignore: cast_nullable_to_non_nullable
              as ISet<String>,
      dateFilter: null == dateFilter
          ? _value.dateFilter
          : dateFilter // ignore: cast_nullable_to_non_nullable
              as String,
      imagesOnly: null == imagesOnly
          ? _value.imagesOnly
          : imagesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      audioOnly: null == audioOnly
          ? _value.audioOnly
          : audioOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      strongTagFilter: null == strongTagFilter
          ? _value.strongTagFilter
          : strongTagFilter // ignore: cast_nullable_to_non_nullable
              as bool,
      resultExist: null == resultExist
          ? _value.resultExist
          : resultExist // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FilterMode with DiagnosticableTreeMixin implements _FilterMode {
  const _$_FilterMode(
      {required this.messages,
      required this.chats,
      required this.tags,
      required this.filterWay,
      required this.searchQuery,
      required this.tagIds,
      required this.chatIds,
      required this.dateFilter,
      required this.imagesOnly,
      required this.audioOnly,
      required this.strongTagFilter,
      required this.resultExist});

  @override
  final IList<MessageModel> messages;
  @override
  final IList<ChatModel> chats;
  @override
  final IList<TagModel> tags;
  @override
  final int filterWay;
  @override
  final String searchQuery;
  @override
  final ISet<String> tagIds;
  @override
  final ISet<String> chatIds;
  @override
  final String dateFilter;
  @override
  final bool imagesOnly;
  @override
  final bool audioOnly;
  @override
  final bool strongTagFilter;
  @override
  final bool resultExist;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimelineState.filterMode(messages: $messages, chats: $chats, tags: $tags, filterWay: $filterWay, searchQuery: $searchQuery, tagIds: $tagIds, chatIds: $chatIds, dateFilter: $dateFilter, imagesOnly: $imagesOnly, audioOnly: $audioOnly, strongTagFilter: $strongTagFilter, resultExist: $resultExist)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimelineState.filterMode'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('chats', chats))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('filterWay', filterWay))
      ..add(DiagnosticsProperty('searchQuery', searchQuery))
      ..add(DiagnosticsProperty('tagIds', tagIds))
      ..add(DiagnosticsProperty('chatIds', chatIds))
      ..add(DiagnosticsProperty('dateFilter', dateFilter))
      ..add(DiagnosticsProperty('imagesOnly', imagesOnly))
      ..add(DiagnosticsProperty('audioOnly', audioOnly))
      ..add(DiagnosticsProperty('strongTagFilter', strongTagFilter))
      ..add(DiagnosticsProperty('resultExist', resultExist));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilterMode &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.filterWay, filterWay) ||
                other.filterWay == filterWay) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other.tagIds, tagIds) &&
            const DeepCollectionEquality().equals(other.chatIds, chatIds) &&
            (identical(other.dateFilter, dateFilter) ||
                other.dateFilter == dateFilter) &&
            (identical(other.imagesOnly, imagesOnly) ||
                other.imagesOnly == imagesOnly) &&
            (identical(other.audioOnly, audioOnly) ||
                other.audioOnly == audioOnly) &&
            (identical(other.strongTagFilter, strongTagFilter) ||
                other.strongTagFilter == strongTagFilter) &&
            (identical(other.resultExist, resultExist) ||
                other.resultExist == resultExist));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(chats),
      const DeepCollectionEquality().hash(tags),
      filterWay,
      searchQuery,
      const DeepCollectionEquality().hash(tagIds),
      const DeepCollectionEquality().hash(chatIds),
      dateFilter,
      imagesOnly,
      audioOnly,
      strongTagFilter,
      resultExist);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterModeCopyWith<_$_FilterMode> get copyWith =>
      __$$_FilterModeCopyWithImpl<_$_FilterMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<MessageModel> messages,
            IList<ChatModel> chats, IList<TagModel> tags, bool isFiltered)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)
        filterMode,
  }) {
    return filterMode(
        messages,
        chats,
        tags,
        filterWay,
        searchQuery,
        tagIds,
        chatIds,
        dateFilter,
        imagesOnly,
        audioOnly,
        strongTagFilter,
        resultExist);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
  }) {
    return filterMode?.call(
        messages,
        chats,
        tags,
        filterWay,
        searchQuery,
        tagIds,
        chatIds,
        dateFilter,
        imagesOnly,
        audioOnly,
        strongTagFilter,
        resultExist);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<MessageModel> messages, IList<ChatModel> chats,
            IList<TagModel> tags, bool isFiltered)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IList<ChatModel> chats,
            IList<TagModel> tags,
            int filterWay,
            String searchQuery,
            ISet<String> tagIds,
            ISet<String> chatIds,
            String dateFilter,
            bool imagesOnly,
            bool audioOnly,
            bool strongTagFilter,
            bool resultExist)?
        filterMode,
    required TResult orElse(),
  }) {
    if (filterMode != null) {
      return filterMode(
          messages,
          chats,
          tags,
          filterWay,
          searchQuery,
          tagIds,
          chatIds,
          dateFilter,
          imagesOnly,
          audioOnly,
          strongTagFilter,
          resultExist);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_FilterMode value) filterMode,
  }) {
    return filterMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_FilterMode value)? filterMode,
  }) {
    return filterMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_FilterMode value)? filterMode,
    required TResult orElse(),
  }) {
    if (filterMode != null) {
      return filterMode(this);
    }
    return orElse();
  }
}

abstract class _FilterMode implements TimelineState {
  const factory _FilterMode(
      {required final IList<MessageModel> messages,
      required final IList<ChatModel> chats,
      required final IList<TagModel> tags,
      required final int filterWay,
      required final String searchQuery,
      required final ISet<String> tagIds,
      required final ISet<String> chatIds,
      required final String dateFilter,
      required final bool imagesOnly,
      required final bool audioOnly,
      required final bool strongTagFilter,
      required final bool resultExist}) = _$_FilterMode;

  @override
  IList<MessageModel> get messages;
  @override
  IList<ChatModel> get chats;
  @override
  IList<TagModel> get tags;
  int get filterWay;
  String get searchQuery;
  ISet<String> get tagIds;
  ISet<String> get chatIds;
  String get dateFilter;
  bool get imagesOnly;
  bool get audioOnly;
  bool get strongTagFilter;
  bool get resultExist;
  @override
  @JsonKey(ignore: true)
  _$$_FilterModeCopyWith<_$_FilterMode> get copyWith =>
      throw _privateConstructorUsedError;
}
