part of 'home_cubit.dart';

enum StreamStatus { initial, success}

extension StreamStatusX on StreamStatus {
  bool get isInitial => this == StreamStatus.initial;
  bool get isSuccess => this == StreamStatus.success;
}

class HomeState extends Equatable {
  final Stream<List<Chat>> chatsStream;
  final List<Chat> chats;
  final StreamStatus streamStatus;

  const HomeState({
    this.chatsStream = const Stream.empty(),
    this.chats = const [],
    this.streamStatus = StreamStatus.initial,
  });

  HomeState copyWith({
    Stream<List<Chat>>? chatsStream,
    List<Chat>? chats,
    StreamStatus? streamStatus,
  }) =>
      HomeState(
        chatsStream: chatsStream ?? this.chatsStream,
        chats: chats ?? this.chats,
        streamStatus: streamStatus ?? this.streamStatus,
      );

  @override
  List<Object> get props => [chats, chatsStream, streamStatus];
}
