import 'package:diary_app/domain/entities/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diary_app/data/repositories/local_repository.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:diary_app/presentation/pages/chat_page/chat_state.dart';

class ChatCubit extends Cubit<ChatEventsUpdated> {
  final int chatId;
  final LocalRepository localRepository;
  bool get isEmpty => state.chatEvents.isEmpty;

  ChatCubit(this.chatId, this.localRepository) : super(ChatEventsUpdated(chatEvents: const [])) {
    initialize();
  }

  Future<List<Chat>> getChats() async {
    return await localRepository.loadChats();
  }

  Future<void> initialize() async {
    final chats = await localRepository.loadChatEvents(chatId);
    emit(state.copyWith(chatEvents: chats));
  }

  Future<void> removeSelectedItems() async {
    List<int> ids = [];
    for (var e in state.chatEvents) {
      if (e.isSelected) ids.add(e.id);
    }
    await localRepository.removeSelectedItems(ids);

    state.chatEvents.removeWhere((element) => element.isSelected);
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  Future<void> changeFavoriteness(bool isFavorite) async {
    List<int> ids = [];
    for (var e in state.chatEvents) {
      if (e.isSelected) ids.add(e.id);
    }
    await localRepository.changeFavoriteness(ids, isFavorite);

    for (var e in state.chatEvents) {
      if (e.isSelected) {
        e.isFavorite = isFavorite;
      }
    }
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  void removeSelections() {
    for (var e in state.chatEvents) {
      e.isSelected = false;
    }
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  Future<void> editEvent(int eventIndex, Event editedEvent) async {
    await localRepository.editEvent(editedEvent);

    state.chatEvents[eventIndex] = editedEvent;
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  Future<void> addEvent(Event newEvent) async {
    final id = await localRepository.addEvent(newEvent);
    final eventWithId = newEvent;
    eventWithId.id = id;

    state.chatEvents.add(newEvent);
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  void changeSelectionState(int eventIndex) {
    final chat = state.chatEvents;
    chat[eventIndex].isSelected = !chat[eventIndex].isSelected;
    emit(state.copyWith(chatEvents: chat));
  }

  void getSearchResult(String filter) {
    unmarkSearchResults();
    for (var e in state.chatEvents) {
      if (!e.message.toLowerCase().contains(filter.toLowerCase())) {
        e.isDisplayed = false;
      }
    }
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  void unmarkSearchResults() {
    for (var e in state.chatEvents) {
      e.isDisplayed = true;
    }
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  Future<void> moveSelectedItems(int targetChatId) async {
    List<int> ids = [];
    for (var e in state.chatEvents) {
      if (e.isSelected) ids.add(e.id);
    }
    await localRepository.moveSelectedItems(ids, chatId, targetChatId);

    state.chatEvents.removeWhere((element) => element.isSelected);
    emit(state.copyWith(chatEvents: state.chatEvents));
  }

  Future<void> removeItemById(int eventId, int eventIndex) async {
    await localRepository.removeItemById(eventId);

    state.chatEvents.removeAt(eventIndex);
    emit(state.copyWith(chatEvents: state.chatEvents));
  }
}
