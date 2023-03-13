part of 'chat_cubit.dart';

class ChatState {
  final ChatModel chat;

  ChatState(
      {this.chat =
          const ChatModel(iconId: 0, title: '', id: 0, cards: [], date: null)});

  ChatState copyWith({ChatModel? newChat}) => ChatState(chat: newChat ?? chat);

  List<EventCardModel> get cards => chat.isShowingFavourites
      ? List<EventCardModel>.from(
          chat.cards.reversed.where((EventCardModel card) => card.isFavourite),
        )
      : List<EventCardModel>.from(chat.cards.reversed);

  int get cardsLength => chat.isShowingFavourites
      ? chat.cards.where((EventCardModel card) => card.isFavourite).length
      : chat.cards.length;
}
