import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../data/models/models.dart';
import '../../../data/repository/categories_repository.dart';
import '../../../data/repository/events_repository.dart';
import '../../data/repository/tags_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventsRepository _eventsRepository;
  final CategoriesRepository _categoriesRepository;
  final TagsRepository _tagsRepository;

  ChatCubit({required User? user})
      : _eventsRepository = EventsRepository(user: user),
        _categoriesRepository = CategoriesRepository(user: user),
        _tagsRepository = TagsRepository(user: user),
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
    final categories = await _categoriesRepository.readCategories();

    emit(state.copyWith(categories: categories));
  }

  void updateTags() async {
    final tags = await _tagsRepository.readTags();

    emit(state.copyWith(tags: tags));
  }

  void addNewEvent(Event event) async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: ChatStatus.loading));
      await _eventsRepository.addEvent(event);
      emit(state.copyWith(status: ChatStatus.success));
      updateEvents();
    }
  }

  void addNewTag(Tag tag) async {
    await _tagsRepository.addTag(tag);
    final tags = List<Tag>.from(state.tags);
    tags.add(tag);
    emit(state.copyWith(tags: tags));
  }

  void deleteEvent(Event event) async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: ChatStatus.loading));
      await _eventsRepository.deleteEvent(event);
      emit(state.copyWith(status: ChatStatus.success));
      updateEvents();
    }
  }

  void editEvent(Event event) async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: ChatStatus.loading));
      await _eventsRepository.updateEvent(event);
      emit(state.copyWith(status: ChatStatus.success));
      updateEvents();
    }
  }

  void deleteSelectedEvents() {
    for (final eventId in state.selectedEventsIds) {
      deleteEvent(state.events.firstWhere((e) => e.id == eventId));
    }
  }

  void transferSelectedEvents(String destinationChat) async {
    final events = state.events
        .where((event) => state.selectedEventsIds.contains(event.id))
        .map(
          (event) => event.copyWith(
            chatId: destinationChat,
          ),
        )
        .toList();

    await _eventsRepository.updateEvents(events);

    emit(state.copyWith(events: events));
  }

  void copySelectedEvents() {
    var copiedText = '';

    final selectedEvents = state.events.where(
      (event) =>
          state.selectedEventsIds.contains(event.id) && event.image == null,
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

  void changeShowTags(bool showTags) {
    emit(state.copyWith(showTags: showTags));
  }

  void changeText(String text) {
    emit(state.copyWith(text: text));
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
