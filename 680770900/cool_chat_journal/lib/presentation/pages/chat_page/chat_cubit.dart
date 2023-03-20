import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../data/models/models.dart';
import '../../../data/repository/categories_repository.dart';
import '../../../data/repository/events_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventsRepository _eventsRepository;
  final _categoriesRepository = CategoriesRepository();

  ChatCubit({required User? user})
    : _eventsRepository = EventsRepository(user: user), 
      super(const ChatState(chatId: '-'));

  void updateEvents() async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: ChatStatus.loading));

      final events = await _eventsRepository.readEvents(state.chatId);
      events.sort((a, b) => a.changeTime.compareTo(b.changeTime));
      
      emit(
        state.copyWith(   
          events: events,
          status: ChatStatus.success,
        ),
      );
    }
  }

  void updateCategories() async {
    final categories = await _categoriesRepository.loadCategories();

    emit(state.copyWith(categories: categories));
  }

  void addNewEvent(Event event) async {
    await _eventsRepository.addEvent(event);
    updateEvents();
  }
  
  void deleteEvent(Event event) async {
    await _eventsRepository.deleteEvent(event);
    updateEvents();
  }

  void editEvent(Event event) async {
    await _eventsRepository.updateEvent(event);
    updateEvents();
  }

  void deleteSelectedEvents() {
    for (final eventId in state.selectedEventsIds) {
      deleteEvent(state.events.firstWhere((e) => e.id == eventId));
    }
  }

  void transferSelectedEvents(String destinationChat) async {
    final events = state.events
      .where((event) => state.selectedEventsIds.contains(event.id))
      .map((event) => 
        event.copyWith(
          chatId: destinationChat,
        ),
      ).toList();
    
    await _eventsRepository.updateEvents(events);
    
    emit(state.copyWith(events: events));
  }

  void copySelectedEvents() {
    var copiedText = '';

    final selectedEvents = state.events.where(
      (event) => state.selectedEventsIds.contains(event.id) && !event.isImage,
    );

    for (final event in selectedEvents) {
      copiedText += '${event.content}\n';
    }

    Clipboard.setData(
      ClipboardData(
        text: copiedText,
      ),
    );
  }

  void switchEventFavorite(String eventId) {
    final event = state.events.firstWhere((event) => event.id == eventId);
    editEvent(
      event.copyWith(isFavorite: !event.isFavorite),
    );
  }

  void switchSelectedEventsFavorite() {
    final events = state.events
        .map(
          (event) => state.selectedEventsIds.contains(event.id)
              ? event.copyWith(isFavorite: !event.isFavorite)
              : event,
        )
        .toList();

    emit(state.copyWith(events: events));
  }

  void switchSelectStatus(String eventId) {
    final selectedEventsIds = List<String>.from(state.selectedEventsIds);

    if (selectedEventsIds.contains(eventId)) {
      selectedEventsIds.remove(eventId);
    } else {
      selectedEventsIds.add(eventId);
    }

    emit(state.copyWith(selectedEventsIds: selectedEventsIds));
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  void toggleFavoriteMode() {
    emit(state.copyWith(isFavoriteMode: !state.isFavoriteMode));
  }

  void changeShowCategories(bool showCategories) {
    emit(state.copyWith(showCategories: showCategories));
  }

  void selectCategory(String? categoryId) {
    emit(
      state.copyWith(
        selectedCategoryId: NullPropertyWrapper<String?>(categoryId),
      ),
    );
  }

  void loadChat(String chatId) {
    emit(state.copyWith(chatId: chatId));
  }

  void resetSelection() {
    emit(state.copyWith(selectedEventsIds: const []));
  }
}

