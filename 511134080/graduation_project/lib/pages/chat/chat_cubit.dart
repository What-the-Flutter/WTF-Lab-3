import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/chat_model.dart';

import '../../models/event_card_model.dart';
import '../home/home_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final HomeCubit homeCubit;

  ChatCubit({
    required this.homeCubit,
  }) : super(ChatState());

  void init(chatId) {
    final chat = homeCubit.state.chats
        .where((ChatModel chatModel) => chatModel.id == chatId)
        .first;

    emit(
      state.copyWith(
        newChat: chat,
      ),
    );
  }

  void updateChat(ChatModel updatedChat) {
    emit(
      state.copyWith(
        newChat: updatedChat,
      ),
    );
    homeCubit.updateChats(state.chat);
  }

  void toggleFavourites() {
    final chat = state.chat;
    updateChat(
      chat.copyWith(showingFavourites: !chat.isShowingFavourites),
    );
  }

  void addEventCard(EventCardModel card) {
    final chat = state.chat;
    final cards = List<EventCardModel>.from(chat.cards)..add(card);

    updateChat(
      chat.copyWith(newCards: cards, newLastEvent: card),
    );
  }

  void editSelectedCard(newTitle, int newCategory) {
    final chat = state.chat;
    final cards = List<EventCardModel>.from(chat.cards);
    final selectedCard =
        cards.where((EventCardModel card) => card.isSelected).first;

    final index = cards.indexOf(selectedCard);
    cards[index] = selectedCard.copyWith(
      newTitle: newTitle,
      isSelected: false,
      newCategory: newCategory,
    );

    updateChat(
      chat.copyWith(
        newCards: cards,
        newLastEvent: cards.last,
      ),
    );

    cancelSelectionMode();
  }

  void cancelSelectionMode() {
    final chat = state.chat;

    final cards = List<EventCardModel>.from(chat.cards);

    for (int i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(
        isSelectionMode: false,
        isSelected: false,
      );
    }

    updateChat(
      chat.copyWith(
        newCards: cards,
      ),
    );
  }

  Future<void> copySelectedCards() async {
    String text = '';
    final chat = state.chat;

    for (final card in chat.cards
        .where((EventCardModel cardModel) => cardModel.isSelected)) {
      text += '${card.title}\n';
    }

    cancelSelectionMode();
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  void deleteSelectedCards() {
    final chat = state.chat;

    final cards = List<EventCardModel>.from(chat.cards)
      ..removeWhere((EventCardModel cardModel) => cardModel.isSelected);

    final lastEvent = cards.isNotEmpty ? cards.last : null;

    updateChat(chat.copyWith(
      newCards: cards,
      newLastEvent: lastEvent,
    ));
    cancelSelectionMode();
  }

  void manageFavouritesFromSelectionMode() {
    final chat = state.chat;

    final cards = List<EventCardModel>.from(chat.cards);

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isSelected) {
        cards[i] = cards[i].copyWith(
          isFavourite: !cards[i].isFavourite,
          isSelected: false,
        );
      }
    }
    updateChat(
      chat.copyWith(newCards: cards),
    );
    cancelSelectionMode();
  }

  void manageSelectedEvent(EventCardModel cardModel) {
    final chat = state.chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);

    if (cards
                .where((EventCardModel cardModel) => cardModel.isSelected)
                .length ==
            1 &&
        cardModel.isSelected) {
      cancelSelectionMode();
    } else {
      cards[index] = cardModel.copyWith(isSelected: !cardModel.isSelected);
      updateChat(
        chat.copyWith(newCards: cards),
      );
    }
  }

  void manageFavouriteEventCard(EventCardModel cardModel) {
    final chat = state.chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(isFavourite: !cardModel.isFavourite);

    updateChat(
      chat.copyWith(newCards: cards),
    );
  }

  void turnOnSelectionMode(EventCardModel cardModel) {
    final chat = state.chat;
    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(isSelected: true);

    for (var i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(
        isSelectionMode: true,
      );
    }

    updateChat(
      chat.copyWith(
        newCards: cards,
      ),
    );
  }

  void moveSelectedCards(int newChatIndex) {
    final chat = state.chat;
    final destinationChat = homeCubit.state.chats[newChatIndex];

    final cards = chat.cards;
    final movingCards = List<EventCardModel>.from(
      cards.where((EventCardModel card) => card.isSelected),
    );

    final withoutMovingCards = List<EventCardModel>.from(
      cards.where((EventCardModel card) => !card.isSelected),
    );

    final withMovingCards =
        List<EventCardModel>.from(destinationChat.cards..addAll(movingCards));

    for (int i = 0; i < withoutMovingCards.length; i++) {
      withoutMovingCards[i] = withoutMovingCards[i].copyWith(
        isSelected: false,
        isSelectionMode: false,
      );
    }

    for (int i = 0; i < withMovingCards.length; i++) {
      withMovingCards[i] = withMovingCards[i].copyWith(
        isSelected: false,
        isSelectionMode: false,
      );
    }

    emit(
      state.copyWith(
        newChat: chat.copyWith(
          newCards: withoutMovingCards,
        ),
      ),
    );

    homeCubit.updateChats(
      destinationChat.copyWith(
        newCards: withMovingCards,
      ),
    );
  }
}
