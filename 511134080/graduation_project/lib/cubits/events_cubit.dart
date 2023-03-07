import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/chat_model.dart';
import 'package:graduation_project/models/event_card_model.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit({required EventsState initState}) : super(initState);

  void updateChat(ChatModel oldChat, ChatModel newChat) {
    final chats = state.chats;
    final index = state.chats.indexOf(oldChat);
    chats[index] = newChat;
    emit(state.copyWith(chats));
  }

  void addChat(int iconId, String title) {
    final chat = [
      ChatModel(iconId: iconId, title: title, id: UniqueKey(), cards: const [])
    ];

    final chats = List<ChatModel>.from(chat)..addAll(state.chats);
    emit(state.copyWith(chats));
  }

  void deleteChat(chatId) {
    final chats = List<ChatModel>.from(state.chats)
      ..removeWhere((element) => element.id == chatId);
    emit(state.copyWith(chats));
  }

  void editChat(chatId, newIconId, newTitle) {
    final chat = state.getChatById(chatId);
    final editedChat = chat.copyWith(
      newIconId: newIconId,
      newTitle: newTitle,
    );
    updateChat(chat, editedChat);
  }

  void addEventCard(chatId, EventCardModel card) {
    final chat = state.getChatById(chatId);
    final cards = List<EventCardModel>.from(chat.cards)..add(card);
    updateChat(chat, chat.copyWith(newCards: cards, newLastEvent: card));
  }

  void editSelectedCard(chatId, newTitle) {
    final chat = state.getChatById(chatId);
    final cards = List<EventCardModel>.from(chat.cards);
    final selectedCard = cards.where((element) => element.isSelected).first;

    final index = cards.indexOf(selectedCard);
    cards[index] = selectedCard.copyWith(newTitle: newTitle, isSelected: false);

    updateChat(
        chat,
        chat.copyWith(
          newCards: cards,
          newLastEvent: cards.last,
        ));

    cancelSelectionMode(chatId);
  }

  void cancelSelectionMode(chatId) {
    final chat = state.getChatById(chatId);

    final cards = List<EventCardModel>.from(chat.cards);

    for (var i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(
        isSelectionMode: false,
        isSelected: false,
      );
    }

    updateChat(
        chat,
        chat.copyWith(
          newCards: cards,
        ));
  }

  Future<void> copySelectedCards(chatId) async {
    String text = '';
    final chat = state.getChatById(chatId);

    for (final card in chat.cards.where((element) => element.isSelected)) {
      text += '${card.title}\n';
    }

    cancelSelectionMode(chatId);
    await Clipboard.setData(ClipboardData(text: text));
  }

  void deleteSelectedCards(chatId) {
    final chat = state.getChatById(chatId);

    final cards = List<EventCardModel>.from(chat.cards)
      ..removeWhere((element) => element.isSelected);

    final lastEvent = cards.isNotEmpty ? cards.last : null;

    updateChat(
        chat,
        chat.copyWith(
          newCards: cards,
          newLastEvent: lastEvent,
        ));
    cancelSelectionMode(chatId);
  }

  void manageFavouritesFromSelectionMode(chatId) {
    final chat = state.getChatById(chatId);

    final cards = List<EventCardModel>.from(chat.cards);

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isSelected) {
        cards[i] = cards[i].copyWith(
          isFavourite: !cards[i].isFavourite,
          isSelected: false,
        );
      }
    }
    updateChat(chat, chat.copyWith(newCards: cards));
    cancelSelectionMode(chatId);
  }

  void manageSelectedEvent(EventCardModel cardModel) {
    final chatIndex =
        state.chats.indexWhere((element) => element.cards.contains(cardModel));
    final chat = state.chats[chatIndex];

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);

    if (cards.where((element) => element.isSelected).length == 1 &&
        cardModel.isSelected) {
      cancelSelectionMode(chat.id);
    } else {
      cards[index] = cardModel.copyWith(isSelected: !cardModel.isSelected);
      updateChat(chat, chat.copyWith(newCards: cards));
    }
  }

  /*void updateLastEvent(ChatModel chat) {
    if (chat.cards.isNotEmpty) {
      chat = chat.copyWith(newLastEventTitle: chat.cards.last.title);
    } else {
      chat = chat.copyWith(
          newLastEventTitle: 'No events. Click here to create one');
    }
    notifyListeners();
  }*/

  void manageFavouriteEventCard(EventCardModel cardModel) {
    final chatIndex =
        state.chats.indexWhere((element) => element.cards.contains(cardModel));
    final chat = state.chats[chatIndex];

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(isFavourite: !cardModel.isFavourite);

    updateChat(chat, chat.copyWith(newCards: cards));
  }

  void turnOnSelectionMode(EventCardModel cardModel) {
    final chatIndex =
        state.chats.indexWhere((element) => element.cards.contains(cardModel));
    final chat = state.chats[chatIndex];

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(isSelected: true);

    for (var i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(
        isSelectionMode: true,
      );
    }

    updateChat(
        chat,
        chat.copyWith(
          newCards: cards,
        ));
  }
}
