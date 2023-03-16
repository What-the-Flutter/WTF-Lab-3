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
    final events = await state.eventsRepository.receiveAllChatEvents(chat.id);
    emit(
      state.copyWith(
        newChat: chat.copyWith(
          newEvents: events,
        ),
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
        final event = Event(
          chatId: state.chat.id,
          title: title,
          time: DateTime.now(),
          id: UniqueKey().toString(),
          categoryIndex: state._categoryIconIndex,
        );

        if (state._isSelectionMode) {
          cancelSelectionMode();
        }
        addEvent(event);
      }
    } else {
      editSelectedEvent(title, state._categoryIconIndex);
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
    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
      ),
    );
  }

  Future<void> editSelectedEvent(String newTitle, int newCategory) async {
    final selectedEvent =
        state._chat.events.where((Event event) => event.isSelected).first;

    await state.eventsRepository.updateEvent(
      selectedEvent.copyWith(
        newTitle: newTitle,
        newCategory: newCategory,
      ),
    );

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
      ),
    );

    cancelSelectionMode();
  }

  Future<void> cancelSelectionMode() async {
    for (final event in state._chat.events) {
      await state.eventsRepository.updateEvent(
        event.copyWith(
          isSelected: false,
        ),
      );
    }

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
        selectionMode: false,
      ),
    );
  }

  Future<void> copySelectedCards() async {
    var text = '';

    final events = state._chat.events.where((Event event) => event.isSelected);

    for (final e in events) {
      text += '${e.title}\n';
    }

    cancelSelectionMode();

    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  Future<void> deleteSelectedCards() async {
    final selectedEvents =
        state._chat.events.where((Event cardModel) => cardModel.isSelected);

    for (final event in selectedEvents) {
      await state.eventsRepository.deleteEventById(event.id);
    }

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
      ),
    );

    cancelSelectionMode();
  }

  void manageTapEvent(Event event) {
    if (!state._isSelectionMode) {
      manageFavouriteEvent(event);
    } else {
      manageSelectedEvent(event);
    }
  }

  Future<void> manageFavouriteEvent(Event event) async {
    final index = state._chat.events.indexOf(event);
    await state.eventsRepository.updateEvent(
      state._chat.events[index].copyWith(
        isFavourite: !event.isFavourite,
      ),
    );

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
      ),
    );
  }

  Future<void> manageSelectedEvent(Event event) async {
    final selectedLength =
        state._chat.events.where((Event e) => e.isSelected).length;

    if (selectedLength == 1 && event.isSelected) {
      cancelSelectionMode();
    } else {
      await state.eventsRepository.updateEvent(
        event.copyWith(
          isSelected: !event.isSelected,
        ),
      );
      final events =
          await state.eventsRepository.receiveAllChatEvents(state._chat.id);

      emit(
        state.copyWith(
          newChat: state._chat.copyWith(
            newEvents: events,
          ),
        ),
      );
    }
  }

  Future<void> manageFavouritesFromSelectionMode() async {
    for (final event in state._chat.events) {
      if (event.isSelected) {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isFavourite: !event.isFavourite,
            isSelected: false,
          ),
        );
      } else {
        await state.eventsRepository.updateEvent(
          event.copyWith(
            isSelected: false,
          ),
        );
      }
    }

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
        selectionMode: false,
      ),
    );
  }

  void manageLongPress(Event event) {
    if (!state._isSelectionMode) {
      turnOnSelectionMode(event);
    }
  }

  Future<void> turnOnSelectionMode(Event selectedEvent) async {
    await state.eventsRepository.updateEvent(
      selectedEvent.copyWith(
        isSelected: true,
      ),
    );

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
        selectionMode: true,
      ),
    );
  }

  Future<void> moveSelectedCards(Chat destinationChat) async {
    final selectedEvents = state._chat.events.where((Event e) => e.isSelected);
    cancelSelectionMode();

    for (final event in selectedEvents) {
      await state.eventsRepository.updateEvent(
        event.copyWith(
          newChatId: destinationChat.id,
          isSelected: false,
        ),
      );
    }

    final events =
        await state.eventsRepository.receiveAllChatEvents(state._chat.id);

    emit(
      state.copyWith(
        newChat: state._chat.copyWith(
          newEvents: events,
        ),
        selectionMode: false,
      ),
    );
  }
}
