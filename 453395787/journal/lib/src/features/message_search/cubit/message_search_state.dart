part of 'message_search_cubit.dart';

@freezed
class MessageSearchState with _$MessageSearchState {
  const factory MessageSearchState.initial() = _Initial;

  const factory MessageSearchState.loading() = _Loading;

  const factory MessageSearchState.empty() = _Empty;

  const factory MessageSearchState.results({
    required IList<Message> messages,
  }) = _Result;
}
