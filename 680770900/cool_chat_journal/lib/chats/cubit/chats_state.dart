part of 'chats_cubit.dart';

enum ChatsStatus { initial, loading, success, failure }

extension ChatsStatusX on ChatsStatus {
  bool get isInitial => this == ChatsStatus.initial;
  bool get isLoading => this == ChatsStatus.loading;
  bool get isSuccess => this == ChatsStatus.success;
  bool get isFailure => this == ChatsStatus.failure;
}

class ChatsState extends Equatable {
  final int nextId;
  final List<Chat> chats;
  final ChatsStatus status;

  const ChatsState({
    this.nextId = 0,
    this.chats = const [],
    this.status = ChatsStatus.initial,
  });

  ChatsState copyWith({
    int? nextId,
    List<Chat>? chats,
    ChatsStatus? status,
  }) => ChatsState(
    nextId: nextId ?? this.nextId,
    chats: chats ?? this.chats,
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [nextId, chats, status];
}
