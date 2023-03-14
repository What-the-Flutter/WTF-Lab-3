import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../../models/event_card_model.dart';
import '../home/home_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final HomeCubit homeCubit;

  ChatCubit({
    required this.homeCubit,
  }) : super(ChatState());

  void init(ChatModel chat) {
    emit(
      state.copyWith(
        newChat: chat,
      ),
    );
  }

  void changeCategoryIcon(int index) {
    if (index == 1) {
      index = 0;
    }
    emit(
      state.copyWith(
        newCategoryIconIndex: index,
      ),
    );
  }

  void toggleChoosingCategory({bool choosingCategory = false}) {
    emit(
      state.copyWith(
        choosingCategory: choosingCategory,
      ),
    );
  }

  void updateChat(ChatModel updatedChat) {
    emit(
      state.copyWith(
        newChat: updatedChat,
      ),
    );
  }

  void toggleFavourites() {
    final chat = state._chat;
    updateChat(
      chat.copyWith(showingFavourites: !chat.isShowingFavourites),
    );
  }

  void toggleEditingMode({bool editingMode = false}) {
    emit(
      state.copyWith(
        editingMode: editingMode,
      ),
    );
  }

  void onEnterSubmitted(String title) {
    if (!state._isEditingMode) {
      if (title != '' || state._categoryIconIndex != 0) {
        final cardModel = EventCardModel(
          title: title,
          time: DateTime.now(),
          id: UniqueKey(),
          categoryIndex: state._categoryIconIndex,
        );

        addEventCard(cardModel);
      }
    } else {
      editSelectedCard(title, state._categoryIconIndex);

      emit(
        state.copyWith(
          editingMode: false,
        ),
      );
    }
    changeCategoryIcon(0);
  }

  void addEventCard(EventCardModel card) {
    final chat = state._chat;
    final cards = List<EventCardModel>.from(chat.cards)..add(card);

    updateChat(
      chat.copyWith(newCards: cards, newLastEvent: card),
    );
  }

  void editSelectedCard(String newTitle, int newCategory) {
    final chat = state._chat;
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
    final chat = state._chat;

    final cards = List<EventCardModel>.from(chat.cards);

    for (var i = 0; i < cards.length; i++) {
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
    var text = '';
    final chat = state._chat;

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
    final chat = state._chat;

    final cards = List<EventCardModel>.from(chat.cards)
      ..removeWhere((EventCardModel cardModel) => cardModel.isSelected);

    final lastEvent = cards.isNotEmpty ? cards.last : null;

    updateChat(chat.copyWith(
      newCards: cards,
      newLastEvent: lastEvent,
    ));
    cancelSelectionMode();
  }

  void manageTapEvent(EventCardModel cardModel) {
    if (!cardModel.isSelectionMode) {
      manageFavouriteEventCard(cardModel);
    } else {
      manageSelectedEvent(cardModel);
    }
  }

  void manageLongPress(EventCardModel cardModel) {
    if (!cardModel.isSelectionMode) {
      turnOnSelectionMode(cardModel);
    }
  }

  void manageFavouritesFromSelectionMode() {
    final chat = state._chat;

    final cards = List<EventCardModel>.from(chat.cards);

    for (var i = 0; i < cards.length; i++) {
      if (cards[i].isSelected) {
        cards[i] = cards[i].copyWith(
          isFavourite: !cards[i].isFavourite,
          isSelected: false,
        );
      }
    }
    updateChat(
      chat.copyWith(
        newCards: cards,
      ),
    );
    cancelSelectionMode();
  }

  void manageSelectedEvent(EventCardModel cardModel) {
    final chat = state._chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);

    final selectedLength =
        cards.where((EventCardModel cardModel) => cardModel.isSelected).length;

    if (selectedLength == 1 && cardModel.isSelected) {
      cancelSelectionMode();
    } else {
      cards[index] = cardModel.copyWith(isSelected: !cardModel.isSelected);
      updateChat(
        chat.copyWith(newCards: cards),
      );
    }
  }

  void manageFavouriteEventCard(EventCardModel cardModel) {
    final chat = state._chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(
      isFavourite: !cardModel.isFavourite,
    );

    updateChat(
      chat.copyWith(newCards: cards),
    );
  }

  void turnOnSelectionMode(EventCardModel cardModel) {
    final chat = state._chat;
    final index = chat.cards.indexOf(cardModel);
    final cards = List<EventCardModel>.from(chat.cards);
    cards[index] = cardModel.copyWith(
      isSelected: true,
    );

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
    final chat = state._chat;
    final destinationChat = homeCubit.state.chats[newChatIndex];

    final cards = chat.cards;
    final movingCards = List<EventCardModel>.from(
      cards.where((EventCardModel card) => card.isSelected),
    );

    final withoutMovingCards = List<EventCardModel>.from(
      cards.where((EventCardModel card) => !card.isSelected),
    );

    final withMovingCards = List<EventCardModel>.from(destinationChat.cards)
      ..addAll(movingCards);

    for (var i = 0; i < withoutMovingCards.length; i++) {
      withoutMovingCards[i] = withoutMovingCards[i].copyWith(
        isSelected: false,
        isSelectionMode: false,
      );
    }

    for (var i = 0; i < withMovingCards.length; i++) {
      withMovingCards[i] = withMovingCards[i].copyWith(
        isSelected: false,
        isSelectionMode: false,
      );
    }

    updateChat(
      chat.copyWith(
        newCards: withoutMovingCards,
      ),
    );

    homeCubit.updateChats(
      destinationChat.copyWith(
        newCards: withMovingCards,
      ),
    );
  }
}
