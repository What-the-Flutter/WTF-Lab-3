import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/event.dart';
import 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  ChatSearchCubit() : super(ChatSearchState(isSearched: false));

  void closeSearch() {
    emit(ChatSearchState(isSearched: false));
  }

  Future<void> searchEvents(String event, List<Event> events) async {
    var searchedEvents = await events.where(
      (element) =>
          (element.textData != null && element.textData!.contains(event)),
    );
    emit(
      state.copyWith(events: searchedEvents.toList(), isSearched: true),
    );
  }
}
