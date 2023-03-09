part of 'chats_cubit.dart';

enum StateStatus { initial, loading, success, failure }

extension ChatsStatusX on StateStatus {
  bool get isInitial => this == StateStatus.initial;
  bool get isLoading => this == StateStatus.loading;
  bool get isSuccess => this == StateStatus.success;
  bool get isFailure => this == StateStatus.failure;
}

class ChatsState extends Equatable {
  final List<Chat> chats;
  final StateStatus status;
  final List<Category> categories;
  final StateStatus categoriesStatus;

  const ChatsState({
    this.chats = const [],
    this.categories = const [],
    this.status = StateStatus.initial,
    this.categoriesStatus = StateStatus.initial,
  });

  ChatsState copyWith({
    List<Chat>? chats,
    StateStatus? status,
    List<Category>? categories,
    StateStatus? categoriesStatus,
  }) => ChatsState(
    chats: chats ?? this.chats,
    status: status ?? this.status,
    categories: categories ?? this.categories,
    categoriesStatus: categoriesStatus ?? this.categoriesStatus,
  );

  @override
  List<Object> get props => [chats, status, categories, categoriesStatus];
}
