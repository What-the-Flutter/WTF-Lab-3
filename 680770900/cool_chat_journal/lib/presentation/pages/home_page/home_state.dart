part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  final List<Chat> chats;
  final HomeStatus status;

  const HomeState({
    this.chats = const [],
    this.status = HomeStatus.initial,
  });

  HomeState copyWith({
    List<Chat>? chats,
    HomeStatus? status,
  }) => HomeState(
    chats: chats ?? this.chats,
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [chats, status];
}
