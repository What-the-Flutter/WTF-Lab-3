import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtager/functions.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import '../../../domain/repositories/api_tag_repository.dart';
import 'chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ApiEventRepository _eventRepository;
  final ApiChatRepository _chatRepository;
  final ApiTagRepository _tagRepository;
  late final StreamSubscription<List<Event>> _eventStream;
  late final StreamSubscription<List<Tag>> _tagStream;

  ChatCubit({
    required ApiEventRepository eventRepository,
    required ApiChatRepository chatRepository,
    required ApiTagRepository tagRepository,
  })  : _eventRepository = eventRepository,
        _chatRepository = chatRepository,
        _tagRepository = tagRepository,
        super(ChatState()) {
    _initEventStream();
  }

  void _initEventStream() async {
    _eventStream = _eventRepository.eventStream.listen((event) {
      print('eventsStream');
      final events = event
          .where(
            (element) => element.parentId == state.chatId,
          )
          .toList();
      events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      final favorites = _getFavorites(events);
      emit(state.copyWith(events: events, favorites: favorites));
    });
    _tagStream = _tagRepository.tagsStream.listen((event) {
      print('tagsStream');
      final tags = event.toList();
      emit(state.copyWith(tags: tags));
    });
  }

  Future<void> init(String id) async {
    final events = await _eventRepository.getEvents(id);
    final favorites = _getFavorites(events);
    favorites.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    final tags = await _tagRepository.getTags();
    emit(state.copyWith(
        events: events, favorites: favorites, chatId: id, tags: tags));
  }

  List<Event> _getFavorites(List<Event> events) {
    return events.where((element) => element.isFavorite).toList();
  }

  void favoritesModeToFalse() {
    emit(state.copyWith(isFavoritesMode: false));
  }

  void _changeIsFavoriteEventToOpposite(
    int index,
    List<Event> events,
    List<Event> favorites,
  ) {
    var event = state.isFavoritesMode ? favorites[index] : events[index];
    final allIndex = state.isFavoritesMode ? events.indexOf(event) : index;
    if (event.isFavorite == true) {
      favorites.remove(event);
      event = event.copyWith(isFavorite: false);
      _eventRepository.updateEvent(event);
      events[allIndex] = event;
    } else {
      event = event.copyWith(isFavorite: true);
      favorites.add(event);
      _eventRepository.updateEvent(event);
      events[allIndex] = event;
    }
  }

  void changeIsFavoriteEvent() {
    final events = List<Event>.from(
        state.isFavoritesMode ? state.favorites : state.events);
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    if (state.selectedCount == 1) {
      _changeIsFavoriteEventToOpposite(
        state.selectedIndex,
        allEvents,
        favorites,
      );
    } else {
      for (var i = 0; i < allEvents.length; i++) {
        if (events[i].isSelected) {
          _changeIsFavoriteEventToOpposite(i, allEvents, favorites);
        }
      }
    }
    favorites.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    _selectionToFalse(allEvents);
    emit(
      state.copyWith(
        selectedCount: 0,
        isSelecting: false,
      ),
    );
  }

  void addEvent(Event event) async {
    final events = List<Event>.from(state.events);
    events.add(event);
    if (hasHashTags(event.text)) {
      for (final tag in extractHashTags(event.text)) {
        await _tagRepository.addTag(Tag(id: '', text: tag));
      }
    }
    await _eventRepository.addEvent(event);
    await _chatRepository.updateLast(
      event.parentId,
      event.text,
      event.dateTime,
      false,
    );
    emit(
      state.copyWith(
        isFavoritesMode: false,
        selectedIcon: 0,
        isSendingImage: false,
        events: events,
      ),
    );
  }

  void changeFavoritesMode() {
    final value = !state.isFavoritesMode;
    emit(
      state.copyWith(
        isFavoritesMode: value,
        isSendingImage: false,
      ),
    );
  }

  void _selectionToFalse(List<Event> events) {
    for (var i = 0; i < events.length; i++) {
      if (events[i].isSelected) {
        events[i] = events[i].copyWith(isSelected: false);
      }
    }
  }

  void selectionToFalse() {
    final events = List<Event>.from(state.events);
    _selectionToFalse(events);
    emit(
      state.copyWith(
        events: events,
        selectedCount: 0,
        isSelecting: false,
        selectedRadioIndex: 0,
      ),
    );
  }

  void changeSelection() {
    final events = List<Event>.from(state.events);
    if (state.isSelecting) {
      _selectionToFalse(events);
      emit(state.copyWith(
          events: events,
          isSelecting: false,
          selectedCount: 0,
          isSelectedImage: false));
    } else {
      var event = events[state.selectedIndex];
      event = event.copyWith(isSelected: true);
      events[state.selectedIndex] = event;
      final isSelectedImageState =
          events[state.selectedIndex].imagePath == '' ? false : true;
      emit(
        state.copyWith(
          events: events,
          isSelecting: true,
          selectedCount: 1,
          isSelectedImage: isSelectedImageState,
        ),
      );
    }
  }

  void decrementSelectedCount() {
    final selectingState = state.selectedCount == 1 ? false : true;
    final isSelectedImageState =
        !selectingState ? false : state.isSelectedImage;
    emit(
      state.copyWith(
        selectedCount: state.selectedCount - 1,
        isSelecting: selectingState,
        isSelectedImage: isSelectedImageState,
      ),
    );
  }

  void decrementFavoritesCount(Event event) {
    final favorites = List<Event>.from(state.favorites);
    favorites.remove(event);
    emit(
      state.copyWith(
        favorites: favorites,
      ),
    );
  }

  void incrementFavoritesCount(Event event) {
    final favorites = List<Event>.from(state.favorites);
    favorites.add(event);
    emit(
      state.copyWith(
        favorites: favorites,
      ),
    );
  }

  void incrementSelectedCount() {
    emit(state.copyWith(selectedCount: state.selectedCount + 1));
  }

  void changeSelectedIndex(int index) {
    final events = List<Event>.from(state.events);
    var isSelectedImageState = state.isSelectedImage;
    if (!state.isSelecting) {
      var event = events[index];
      event = event.copyWith(isSelected: true);
      events[index] = event;
    }
    emit(
      state.copyWith(
        events: events,
        selectedIndex: index,
        isSelecting: true,
        selectedCount: 1,
        isSelectedImage: isSelectedImageState,
      ),
    );
  }

  void changeIsEditingToValue({required bool value, int index = 0}) {
    final events = List<Event>.from(state.events);
    _selectionToFalse(events);
    emit(
      state.copyWith(
        events: events,
        selectedIndex: index,
        isEditing: value,
        isSelecting: false,
        selectedCount: 0,
      ),
    );
  }

  void changeIsTypingToValue(bool value) {
    emit(state.copyWith(isTyping: value));
  }

  void changeIsSendingImageToValue(bool value) {
    emit(state.copyWith(isSendingImage: value));
  }

  void changeSelectedItem(int index) {
    final events = List<Event>.from(state.events);
    final selectedState = events[index].isSelected;
    final bool isSelectedImageState;
    if (selectedState == true) {
      isSelectedImageState =
          events[index].imagePath != '' ? false : state.isSelectedImage;
      decrementSelectedCount();
    } else {
      isSelectedImageState =
          events[index].imagePath != '' ? true : state.isSelectedImage;
      incrementSelectedCount();
    }

    events[index] = events[index].copyWith(isSelected: !selectedState);
    emit(
      state.copyWith(events: events, isSelectedImage: isSelectedImageState),
    );
  }

  void changeIsSelectedImage() {
    emit(state.copyWith(isSelectedImage: !state.isSelectedImage));
  }

  void changeIsSelectingCategory(bool value) {
    final isSendingImage = value ? false : state.isSelectedImage;
    emit(
      state.copyWith(
        isSelectingCategory: value,
        isSendingImage: isSendingImage,
      ),
    );
  }

  void changeSelectedIcon(int index) {
    emit(
      state.copyWith(
        selectedIcon: index,
        isSelectingCategory: false,
      ),
    );
  }

  void changeText(String text) {
    final events = List<Event>.from(state.events);
    var event = events[state.selectedIndex];
    event = event.copyWith(text: text);
    if (state.selectedIndex == events.length - 1) {
      _chatRepository.updateLast(
          event.parentId, event.text, event.dateTime, false);
    }
    _eventRepository.updateEvent(event);
    if (hasHashTags(event.text)) {
      for (final tagText in extractHashTags(event.text)) {
        _tagRepository.updateTag(
            state.tags.firstWhere((element) => element.text == tagText));
      }
    }
    emit(state.copyWith(isEditing: false));
  }

  void changeRadioIndex(int? value) {
    if (value != null) {
      emit(state.copyWith(selectedRadioIndex: value));
    } else {
      emit(state.copyWith(selectedRadioIndex: 0));
    }
  }

  void _deleteEvents(List<Event> allEvents, List<Event> favorites, int index) {
    final event = state.isFavoritesMode ? favorites[index] : allEvents[index];
    if (state.selectedCount <= 1) {
      allEvents.remove(event);
      _eventRepository.deleteEvent(event);
      for (final tagText in extractHashTags(event.text)) {
        _tagRepository.removeTag(
            state.tags.firstWhere((element) => element.text == tagText));
      }
    } else {
      var i = 0;
      while (i < allEvents.length) {
        if (allEvents[i].isSelected) {
          _eventRepository.deleteEvent(allEvents[i]);
          for (final tagText in extractHashTags(event.text)) {
            _tagRepository.removeTag(
                state.tags.firstWhere((element) => element.text == tagText));
          }
        }
        allEvents.removeWhere((element) => element.isSelected);
        i++;
      }
    }
  }

  void deleteEvents(int index) {
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    final chatId = allEvents.first.parentId;
    _deleteEvents(allEvents, favorites, index);
    _selectionToFalse(allEvents);
    if (allEvents.isNotEmpty) {
      final event = allEvents.last;
      _chatRepository.updateLast(
          event.parentId, event.text, event.dateTime, false);
    } else {
      _chatRepository.updateLast(
          chatId, 'No events. Click to create one', null, false);
    }
    emit(
      state.copyWith(
        isSelecting: false,
        selectedCount: 0,
      ),
    );
  }

  void onTapEvent(int index) {
    final events = List<Event>.from(
      state.isFavoritesMode ? state.favorites : state.events,
    );
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    var selectedCount = state.selectedCount;
    if (!state.isSelecting) {
      if (state.selectedCount <= 1) {
        _changeIsFavoriteEventToOpposite(index, allEvents, favorites);
      } else {
        for (var i = 0; i < state.events.length; i++) {
          if (events[i].isSelected) {
            _changeIsFavoriteEventToOpposite(i, allEvents, favorites);
          }
        }
      }
      favorites.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else {
      final event =
          allEvents[index].copyWith(isSelected: !allEvents[index].isSelected);
      allEvents[index] = event;
      selectedCount = event.isSelected ? selectedCount + 1 : selectedCount - 1;
    }
    emit(
      state.copyWith(
        selectedIndex: index,
        events: allEvents,
        favorites: favorites,
        selectedCount: selectedCount,
      ),
    );
  }

  void onDismissed(
      {required int index,
      required bool startToEnd,
      required bool endToStart}) {
    final events = List<Event>.from(state.events);
    final favorites = List<Event>.from(state.favorites);
    var isEditing = state.isEditing;
    var selectedIndex = state.selectedIndex;
    if (startToEnd) {
      if (state.events[index].imagePath != '') {
        isEditing = true;
      }
      _selectionToFalse(events);
    } else if (endToStart) {
      selectedIndex = index;
      _deleteEvents(events, favorites, index);
    }
    emit(
      state.copyWith(
        selectedIndex: selectedIndex,
        isSelecting: false,
        selectedCount: 0,
        isEditing: isEditing,
      ),
    );
  }

  void _changeLastMessage() {
    if (state.selectedIndex == state.events.length - 1) {
      if (state.events.length == 1) {
        _chatRepository.updateLast(
          state.chatId,
          'No events. Click to create one',
          null,
          false,
        );
      } else {
        _chatRepository.updateLast(
          state.chatId,
          state.events[state.selectedIndex - 1].text,
          state.events[state.selectedIndex - 1].dateTime,
          false,
        );
      }
    }
  }

  void transferEvents(String id) {
    final events = List<Event>.from(state.events);
    if (state.selectedCount == 1) {
      final event = events[state.selectedIndex];
      _chatRepository.updateLast(id, event.text, event.dateTime, true);
      events.remove(event);
      _eventRepository.updateEvent(
        event.copyWith(parentId: id, isSelected: false),
      );
    } else {
      var i = 0;
      while (i < events.length) {
        if (events[i].isSelected) {
          _chatRepository.updateLast(
              id, events[i].text, events[i].dateTime, true);
          _eventRepository.updateEvent(
            events[i].copyWith(
              parentId: id,
              isSelected: false,
            ),
          );
        }
        events.removeWhere((element) => element.isSelected);
      }
    }
    if (events.isNotEmpty) {
      _chatRepository.updateLast(
        state.chatId,
        events.last.text,
        events.last.dateTime,
        false,
      );
    } else {
      _chatRepository.updateLast(
        state.chatId,
        'No events. Click to create one',
        null,
        false,
      );
    }
    emit(
      state.copyWith(
        isSelecting: false,
        selectedCount: 0,
        selectedRadioIndex: 0,
      ),
    );
  }

  Future<List<Chat>> getChats() async {
    return await _chatRepository.getChats();
  }

  void changeAddingTag(bool value) {
    emit(state.copyWith(isAddingTag: value));
  }

  void changeCurrentInput(String value) {
    emit(state.copyWith(currentInput: value));
  }

  @override
  Future<void> close() {
    _eventStream.cancel();
    _tagStream.cancel();
    return super.close();
  }

  Future<List<Tag>> getTags() async {
    return await _tagRepository.getTags();
  }

  void addOrRemoveSearchTag(Tag tag) {
    final searchTags = List<String>.from(state.searchTags);
    if (searchTags.contains(tag.text)) {
      searchTags.remove(tag.text);
    } else {
      searchTags.add(tag.text);
    }
    emit(state.copyWith(searchTags: searchTags));
  }
}
