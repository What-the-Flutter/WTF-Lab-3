part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Chat> chats;
  final int currentTab;

  const HomeState({
    this.chats = const [],
    this.currentTab = 0,
  });

  HomeState copyWith({
    List<Chat>? chats,
    int? currentTab,
  }) =>
      HomeState(
        chats: chats ?? this.chats,
        currentTab: currentTab ?? this.currentTab,
      );

  @override
  List<Object?> get props => [chats, currentTab];
}
