import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/models/message.dart';

part 'chat_search_state.freezed.dart';

@freezed
class ChatSearchState with _$ChatSearchState {
  const factory ChatSearchState.initial() = _InitialChatSearchState;

  const factory ChatSearchState.empty() = _EmptyChatSearchState;

  factory ChatSearchState.withResults({
    required List<Message> messages,
  }) = _WithResultChatSearchState;
}
