part of 'message_overview_cubit.dart';

@freezed
class MessageOverviewState with _$MessageOverviewState {
  const factory MessageOverviewState({
    required MessageList messages,
  }) = _MessageOverviewState;
}
