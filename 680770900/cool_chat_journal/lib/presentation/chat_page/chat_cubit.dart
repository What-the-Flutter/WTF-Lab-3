import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../data/models/models.dart';
import '../../data/repository/categories_repository.dart';
import '../../data/repository/events_repository.dart';
import '../../data/repository/tags_repository.dart';
import '../../utils/null_wrapper.dart';
import '../chat_editor_page/chat_editor_cubit.dart';

part 'chat_state.dart';

typedef EventsSubscription = StreamSubscription<List<Event>>;
typedef CategoriesSubscription = StreamSubscription<List<Category>>;
typedef TagsSubscription = StreamSubscription<List<Tag>>;

class ChatCubit extends Cubit<ChatState> {
  EventsSubscription? _eventsSubscription;
  CategoriesSubscription? _categoriesSubscription;
  TagsSubscription? _tagsSubscription;

  final EventsRepository eventsRepository;
  final CategoriesRepository categoriesRepository;
  final TagsRepository tagsRepository;

  ChatCubit({
    required this.eventsRepository,
    required this.categoriesRepository,
    required this.tagsRepository,
  }) : super(const ChatState(chatId: '-'));

  void subscribeStreams() {
    _eventsSubscription =
        eventsRepository.eventsStream.listen(_setEvents);

    _categoriesSubscription =
        categoriesRepository.categoriesStream.listen(_setCategories);

    _tagsSubscription =
        tagsRepository.tagsStream.listen(_setTags);
  }

  void unsubscribeStreams() {
    _eventsSubscription?.cancel();
    _categoriesSubscription?.cancel();
    _tagsSubscription?.cancel();
  }

  Future<void> readImage(Event event) async {
    try {
      final Uint8List image;
      if (state.images?[event.id] != null) {
        image = state.images![event.id]!;
      } else {
        image = await eventsRepository.readImage(event);
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

    await eventsRepository.addEvent(event);
  }

  void deleteEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList();
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await eventsRepository.deleteEvent(event);
  }

  void editEvent(Event event) async {
    final events = state.events.where((e) => e.id != event.id).toList()
      ..add(event);
    _sortEvents(events);
    emit(state.copyWith(events: events));

    await eventsRepository.updateEvent(event);
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

    await eventsRepository.updateEvents(events);

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

  void addNewTag(String tag) async {
    await tagsRepository.addTag(tag);
  }

  void deleteTag(Tag tag) async {
    await tagsRepository.deleteLink(tag.id);
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
        selectedCategoryId: NullWrapper<String?>(categoryId),
      ),
    );
  }

  void loadChat(String? chatId) {
    emit(state.copyWith(chatId: NullWrapper(chatId)));
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
