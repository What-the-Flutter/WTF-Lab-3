import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../home/home_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final HomeCubit homeCubit;

  ChatCubit({
    required this.homeCubit,
  }) : super(ChatState());

  void init(Chat chat) {
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

  void updateChat(Chat updatedChat) {
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
        final cardModel = Event(
          chatId: state.chat.id,
          title: title,
          time: DateTime.now(),
          id: UniqueKey().toString(),
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

  void addEventCard(Event card) {
    final chat = state._chat;
    final cards = List<Event>.from(chat.cards)..add(card);

    updateChat(
      chat.copyWith(newCards: cards, newLastEvent: card),
    );
  }

  void editSelectedCard(String newTitle, int newCategory) {
    final chat = state._chat;
    final cards = List<Event>.from(chat.cards);
    final selectedCard = cards.where((Event card) => card.isSelected).first;

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

    final cards = List<Event>.from(chat.cards);

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

    for (final card
        in chat.cards.where((Event cardModel) => cardModel.isSelected)) {
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

    final cards = List<Event>.from(chat.cards)
      ..removeWhere((Event cardModel) => cardModel.isSelected);

    final lastEvent = cards.isNotEmpty ? cards.last : null;

    updateChat(chat.copyWith(
      newCards: cards,
      newLastEvent: lastEvent,
    ));
    cancelSelectionMode();
  }

  void manageTapEvent(Event cardModel) {
    if (!cardModel.isSelectionMode) {
      manageFavouriteEventCard(cardModel);
    } else {
      manageSelectedEvent(cardModel);
    }
  }

  void manageLongPress(Event cardModel) {
    if (!cardModel.isSelectionMode) {
      turnOnSelectionMode(cardModel);
    }
  }

  void manageFavouritesFromSelectionMode() {
    final chat = state._chat;

    final cards = List<Event>.from(chat.cards);

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

  void manageSelectedEvent(Event cardModel) {
    final chat = state._chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<Event>.from(chat.cards);

    final selectedLength =
        cards.where((Event cardModel) => cardModel.isSelected).length;

    if (selectedLength == 1 && cardModel.isSelected) {
      cancelSelectionMode();
    } else {
      cards[index] = cardModel.copyWith(isSelected: !cardModel.isSelected);
      updateChat(
        chat.copyWith(newCards: cards),
      );
    }
  }

  void manageFavouriteEventCard(Event cardModel) {
    final chat = state._chat;

    final index = chat.cards.indexOf(cardModel);
    final cards = List<Event>.from(chat.cards);
    cards[index] = cardModel.copyWith(
      isFavourite: !cardModel.isFavourite,
    );

    updateChat(
      chat.copyWith(newCards: cards),
    );
  }

  void turnOnSelectionMode(Event cardModel) {
    final chat = state._chat;
    final index = chat.cards.indexOf(cardModel);
    final cards = List<Event>.from(chat.cards);
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
    final movingCards = List<Event>.from(
      cards.where((Event card) => card.isSelected),
    );

    final withoutMovingCards = List<Event>.from(
      cards.where((Event card) => !card.isSelected),
    );

    final withMovingCards = List<Event>.from(destinationChat.cards)
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
