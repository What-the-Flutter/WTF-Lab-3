part of 'home_cubit.dart';


class HomeState extends Equatable {
  final ChatsSubscription? streamSubscription;
  final List<Chat> chats;

  const HomeState({
    this.streamSubscription,
    this.chats = const [],
  });

  HomeState copyWith({
    _NullWrapper<ChatsSubscription?>? streamSubscription,
    List<Chat>? chats,
  }) =>
      HomeState(
        chats: chats ?? this.chats,
        streamSubscription: streamSubscription != null 
          ? streamSubscription.value
          : this.streamSubscription,
      );

  @override
  List<Object?> get props => [chats, streamSubscription];
}

class _NullWrapper<T> {
  final T value;

  const _NullWrapper(this.value);
}
