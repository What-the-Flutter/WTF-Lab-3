import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../data/models/models.dart';
import '../../data/repository/categories_repository.dart';
import '../../data/repository/events_repository.dart';
import '../../data/repository/tags_repository.dart';

part 'chat_state.dart';

typedef EventsSubscription = StreamSubscription<List<Event>>;

class ChatCubit extends Cubit<ChatState> {
  final EventsRepository _eventsRepository;
  final CategoriesRepository _categoriesRepository;
  final TagsRepository _tagsRepository;

  ChatCubit({required User? user})
      : _eventsRepository = EventsRepository(user: user),
        _categoriesRepository = CategoriesRepository(user: user),
        _tagsRepository = TagsRepository(user: user),
        super(const ChatState(chatId: '-'));

  void subscribeEventsStream() {
    final subscription = _eventsRepository.eventsStream.listen(_setEvents);

    emit(
      state.copyWith(
        eventsSubscription: _NullWrapper<EventsSubscription?>(subscription),
      ),
    );
  }

  void unsubscribeEventsStream() {
    if (state.eventsSubscription != null) {
      state.eventsSubscription!.cancel();

      emit(
        state.copyWith(
          eventsSubscription: const _NullWrapper<EventsSubscription?>(null),
        ),
      );
    }
  }

  Future<void> readImage(Event event) async {
    try {
      final Uint8List image;
      if (state.images?[event.id] != null) {
        image = state.images![event.id]!; 
      } else {
        image = await _eventsRepository.readImage(event);
      }
    
      final events = state.events
        .where((e) => e.id != event.id)
        .toList()
        ..add(event.copyWith(image: NullWrapper<Uint8List>(image)));

      _sortEvents(events);

      emit(
        state.copyWith(
          events: events,
        ),
      );
    } catch (_) { }
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
    final events = List<Event>.from(state.events)..add(event);
    _sortEvents(events);

    final _NullWrapper<Map<String, Uint8List>?>? imagesWrapper;
    if (event.image != null) {
      final images = Map<String, Uint8List>.from(
        state.images ?? <String, Uint8List>{},
      );
      images[event.id] = event.image!;

      imagesWrapper = _NullWrapper<Map<String, Uint8List>>(images);
    } else {
      imagesWrapper = null;
    }


    emit(
      state.copyWith(
        events: events,
        images: imagesWrapper,
      )
    );

    await _eventsRepository.addEvent(event);
  }

  void addNewTag(Tag tag) async {
    await _tagsRepository.addTag(tag);
    final tags = List<Tag>.from(state.tags);
    tags.add(tag);
    emit(state.copyWith(tags: tags));
  }

  void deleteEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList();
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await _eventsRepository.deleteEvent(event);
  }

  void editEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList()..add(event);
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await _eventsRepository.updateEvent(event);
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
        selectedCategoryId: _NullWrapper<String?>(categoryId),
      ),
    );
  }

  void loadChat(String chatId) {
    emit(state.copyWith(chatId: chatId));
  }

  void resetSelection() {
    emit(state.copyWith(selectedEventsIds: const []));
  }

  void _sortEvents(List<Event> events) {
    events.sort((a, b) => a.changeTime.compareTo(b.changeTime));
  }

  bool _isUpdate(List<Event> newEvents) {
    if (state.events.isEmpty) return true;

    for (final event in state.events) {
      if (!newEvents.contains(event)) return true;
    }
    
    return false;
  } 

  void _setEvents(List<Event> events) async {
    final chatsEvents = events
        .where((event) => event.chatId == state.chatId)
        .toList();
    _sortEvents(chatsEvents);

    if (_isUpdate(chatsEvents)) {
      emit(state.copyWith(events: chatsEvents));    
    }
  }
}
