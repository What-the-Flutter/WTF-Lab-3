part of 'message_search_cubit.dart';

@freezed
class MessageSearchState with _$MessageSearchState {
  const MessageSearchState._();

  const factory MessageSearchState.initial() = _Initial;

  const factory MessageSearchState.loading({
    required String query,
    IList<Tag>? queryTags,
  }) = _Loading;

  const factory MessageSearchState.empty({
    required String query,
    IList<Tag>? queryTags,
  }) = _Empty;

  const factory MessageSearchState.results({
    required String query,
    IList<Tag>? queryTags,
    required IList<Message> messages,
  }) = _Result;

  String? get query {
    return map(
      initial: (initial) => '',
      loading: (loading) => loading.query,
      empty: (empty) => empty.query,
      results: (results) => results.query,
    );
  }

  IList<Tag>? get queryTags {
    return mapOrNull(
      loading: (loading) => loading.queryTags,
      empty: (empty) => empty.queryTags,
      results: (results) => results.queryTags,
    );
  }
}
