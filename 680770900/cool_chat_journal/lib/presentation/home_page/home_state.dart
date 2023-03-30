part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Chat> chats;

  const HomeState({
    this.chats = const [],
  });

  HomeState copyWith({
    List<Chat>? chats,
    List<Event>? events,
    int? selectedTab,
  }) =>
      HomeState(
        chats: chats ?? this.chats,
      );

  @override
  List<Object?> get props => [chats];
}
