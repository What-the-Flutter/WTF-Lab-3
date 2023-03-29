part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Chat> chats;

  const HomeState({
    this.chats = const [],
  });

  HomeState copyWith({
    _NullWrapper<ChatsSubscription?>? streamSubscription,
    List<Chat>? chats,
  }) =>
      HomeState(
        chats: chats ?? this.chats,
      );

  @override
  List<Object?> get props => [chats];
}

class _NullWrapper<T> {
  final T value;

  const _NullWrapper(this.value);
}
