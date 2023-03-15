import 'package:bloc/bloc.dart';
import 'package:chats_repository/chats_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState(chat: Chat.empty));

  void addNewEvent(Event event) {
    final events = List<Event>.from(state.chat.events)..add(event);
    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void deleteEvent(String eventId) {
    final events = state.chat.events
        .where(
          (event) => event.id != eventId,
        )
        .toList();

    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void deleteSelectedEvents() {
    final events = state.chat.events
        .where(
          (event) => !state.selectedEventsIds.contains(event.id),
        )
        .toList();

    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void editEvent(String id, Event newEvent) {
    final events = state.chat.events
        .map<Event>(
          (event) => event.id == id ? newEvent : event,
        )
        .toList();

    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void switchEventFavorite(String eventId) {
    final events = state.chat.events
        .map(
          (event) => event.id == eventId
              ? event.copyWith(isFavorite: !event.isFavorite)
              : event,
        )
        .toList();

    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void switchSelectedEventsFavorite() {
    final events = state.chat.events
        .map(
          (event) => state.selectedEventsIds.contains(event.id)
              ? event.copyWith(isFavorite: !event.isFavorite)
              : event,
        )
        .toList();

    emit(
      state.copyWith(
        chat: state.chat.copyWith(events: events),
      ),
    );
  }

  void switchSelectStatus(String eventId) {
    final selectedEventsIds = List<String>.from(state.selectedEventsIds);

    if (selectedEventsIds.contains(eventId)) {
      selectedEventsIds.remove(eventId);
    } else {
      selectedEventsIds.add(eventId);
    }

    emit(
      state.copyWith(
        selectedEventsIds: selectedEventsIds,
      ),
    );
  }

  void toggleEditMode() {
    emit(
      state.copyWith(
        isEditMode: !state.isEditMode,
      ),
    );
  }

  void toggleFavoriteMode() {
    emit(
      state.copyWith(
        isFavoriteMode: !state.isFavoriteMode,
      ),
    );
  }

  void changeShowCategories(bool showCategories) {
    emit(state.copyWith(showCategories: showCategories));
  }

  void selectCategory(Category? category) {
    emit(
      state.copyWith(
        selectedCategory: NullPropertyWrapper<Category?>(category),
      ),
    );
  }

  void createChat(Chat chat) {
    emit(
      state.copyWith(
        chat: chat,
      ),
    );
  }

  void resetSelection() {
    emit(
      state.copyWith(
        selectedEventsIds: const [],
      ),
    );
  }
}
