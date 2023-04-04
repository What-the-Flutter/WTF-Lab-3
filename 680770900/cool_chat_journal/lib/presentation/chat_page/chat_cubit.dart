import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../data/models/models.dart';
import '../../data/repository/categories_repository.dart';
import '../../data/repository/events_repository.dart';
import '../../data/repository/tags_repository.dart';
import '../../utils/null_wrapper.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventsRepository _eventsRepository;
  final CategoriesRepository _categoriesRepository;
  final TagsRepository _tagsRepository;
  
  late final StreamSubscription<List<Event>> _eventsSubscription;
  late final StreamSubscription<List<Category>> _categoriesSubscription;
  late final StreamSubscription<List<Tag>> _tagsSubscription;

  ChatCubit(
    this._eventsRepository,
    this._categoriesRepository,
    this._tagsRepository,
  ) : super(const ChatState(chatId: '-')) {
    _eventsSubscription = _eventsRepository.eventsStream.listen(_setEvents);
    _tagsSubscription = _tagsRepository.tagsStream.listen(_setTags);
    _categoriesSubscription =
        _categoriesRepository.categoriesStream.listen(_setCategories);
  }

  @override
  Future<void> close() {
    _eventsSubscription.cancel();
    _categoriesSubscription.cancel();
    _tagsSubscription.cancel();
    return super.close();
  }

  Future<void> readImage(Event event) async {
    try {
      final Uint8List image;
      if (state.images?[event.id] != null) {
        image = state.images![event.id]!;
      } else {
        image = await _eventsRepository.readImage(event);
      }

      final events = state.events.where((e) => e.id != event.id).toList()
        ..add(event.copyWith(image: NullWrapper<Uint8List>(image)));

      _sortEvents(events);

      emit(
        state.copyWith(
          events: events,
        ),
      );
    } catch (_) {}
  }

  void addNewEvent(Event event) async {
    final events = List<Event>.from(state.events)..add(event);
    _sortEvents(events);

    final NullWrapper<Map<String, Uint8List>?>? imagesWrapper;
    if (event.image != null) {
      final images = Map<String, Uint8List>.from(
        state.images ?? <String, Uint8List>{},
      );
      images[event.id] = event.image!;

      imagesWrapper = NullWrapper<Map<String, Uint8List>>(images);
    } else {
      imagesWrapper = null;
    }

    emit(state.copyWith(
      events: events,
      images: imagesWrapper,
    ));

    await _eventsRepository.addEvent(event);
  }

  void deleteEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList();
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await _eventsRepository.deleteEvent(event);
  }

  void editEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList()
      ..add(event);
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await _eventsRepository.updateEvent(event);
  }

  void deleteSelectedEvents() {
    for (final event in state.selectedEvents) {
      deleteEvent(state.events.firstWhere((e) => e == event));
    }
  }

  void transferSelectedEvents(String destinationChat) async {
    final events = state.events
        .where((event) => state.selectedEvents.contains(event))
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
      (event) => state.selectedEvents.contains(event) && event.image == null,
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
          (event) => state.selectedEvents.contains(event)
              ? event.copyWith(isFavorite: !event.isFavorite)
              : event,
        )
        .toList();

    emit(state.copyWith(events: events));
  }

  void addNewTag(String tag) async {
    await _tagsRepository.addTag(tag);
  }

  void deleteTag(Tag tag) async {
    await _tagsRepository.deleteLink(tag.id);
  }

  void switchSelectStatus(Event event) {
    final selectedEvents = List<Event>.from(state.selectedEvents);

    if (selectedEvents.contains(event)) {
      selectedEvents.remove(event);
    } else {
      selectedEvents.add(event);
    }

    emit(state.copyWith(selectedEvents: selectedEvents));
  }

  void addEditedEvent(Event event) {
    emit(state.copyWith(editedEvent: NullWrapper(event)));
  }

  void removeEditedEvent() {
    emit(state.copyWith(editedEvent: const NullWrapper(null)));
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
        selectedCategoryId: NullWrapper<String?>(categoryId),
      ),
    );
  }

  void loadChat(String? chatId) {
    emit(state.copyWith(chatId: NullWrapper(chatId)));
  }

  void resetSelection() {
    emit(state.copyWith(selectedEvents: const []));
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
    _sortEvents(events);
    if (_isUpdate(events)) {
      emit(state.copyWith(events: events));
    }
  }

  void _setCategories(List<Category> categories) async {
    emit(state.copyWith(categories: categories));
  }

  void _setTags(List<Tag> tags) async {
    emit(state.copyWith(tags: tags));
  }
}
