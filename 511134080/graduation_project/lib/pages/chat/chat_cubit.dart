import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../repositories/event_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  Future<void> init(Chat chat) async {
    final cards = await state.eventsRepository.receiveAllChatEvents(chat.id);
    emit(
      state.copyWith(
        newCards: cards,
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

  Future<void> toggleFavourites() async {
    final updatedChat = state._chat.copyWith(
      showingFavourites: !state._chat.isShowingFavourites,
    );
    emit(
      state.copyWith(
        newChat: updatedChat,
      ),
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

        addEvent(cardModel);
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

  Future<void> addEvent(Event event) async {
    await state.eventsRepository.insertEvent(event);
    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);
    emit(
      state.copyWith(
        newCards: cards,
      ),
    );
  }

  Future<void> editSelectedCard(String newTitle, int newCategory) async {
    final selectedEvent =
        state._cards.where((Event card) => card.isSelected).first;

    await state.eventsRepository.updateEvent(
      selectedEvent.copyWith(
        newTitle: newTitle,
        newCategory: newCategory,
      ),
    );

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );

    cancelSelectionMode();
  }

  Future<void> cancelSelectionMode() async {
    for (final event in state._cards) {
      await state.eventsRepository.updateEvent(
        event.copyWith(
          isSelectionMode: false,
          isSelected: false,
        ),
      );
    }

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );
  }

  Future<void> copySelectedCards() async {
    var text = '';

    final cards = state._cards.where((Event cardModel) => cardModel.isSelected);
    for (final card in cards) {
      text += '${card.title}\n';
    }

    cancelSelectionMode();

    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  Future<void> deleteSelectedCards() async {
    final selectedCards =
        state._cards.where((Event cardModel) => cardModel.isSelected);

    for (final card in selectedCards) {
      await state.eventsRepository.deleteEventById(card.id);
    }

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );

    cancelSelectionMode();
  }

  void manageTapEvent(Event cardModel) {
    if (!cardModel.isSelectionMode) {
      manageFavouriteEventCard(cardModel);
    } else {
      manageSelectedEvent(cardModel);
    }
  }

  Future<void> manageFavouriteEventCard(Event cardModel) async {
    final index = state._cards.indexOf(cardModel);

    await state.eventsRepository.updateEvent(
      state._cards[index].copyWith(
        isFavourite: !cardModel.isFavourite,
      ),
    );

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );
  }

  Future<void> manageSelectedEvent(Event event) async {
    final selectedLength =
        state._cards.where((Event cardModel) => cardModel.isSelected).length;

    if (selectedLength == 1 && event.isSelected) {
      cancelSelectionMode();
    } else {
      await state.eventsRepository.updateEvent(
        event.copyWith(
          isSelected: !event.isSelected,
        ),
      );
      final cards =
          await state.eventsRepository.receiveAllChatEvents(state._chat.id);
      emit(
        state.copyWith(
          newCards: cards,
        ),
      );
    }
  }

  Future<void> manageFavouritesFromSelectionMode() async {
    for (final event in state._cards) {
      if (event.isSelected) {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isFavourite: !event.isFavourite,
            isSelected: false,
            isSelectionMode: false,
          ),
        );
      } else {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isSelected: false,
            isSelectionMode: false,
          ),
        );
      }
    }

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );
  }

  void manageLongPress(Event cardModel) {
    if (!cardModel.isSelectionMode) {
      turnOnSelectionMode(cardModel);
    }
  }

  Future<void> turnOnSelectionMode(Event cardModel) async {
    for (final event in state._cards) {
      if (event.id == cardModel.id) {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isSelectionMode: true,
            isSelected: true,
          ),
        );
      } else {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isSelectionMode: true,
          ),
        );
      }
    }

    final cards =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newCards: cards,
      ),
    );
  }

  /* TODO void moveSelectedCards(int newChatIndex) {
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
    }*/
}
