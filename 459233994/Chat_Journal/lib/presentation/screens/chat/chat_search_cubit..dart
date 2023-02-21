import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/event.dart';
import 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  ChatSearchCubit() : super(ChatNotSearch());

  void changeState() {
    (state is ChatNotSearch || state is ChatSearchLoaded)
        ? emit(ChatSearchNotLoaded())
        : emit(ChatNotSearch());
  }

  Future<void> searchEvents(String event, List<Event> events) async {
    var searchedEvents = await events.where(
      (element) =>
          (element.textData != null && element.textData!.contains(event)),
    );
    print(searchedEvents.length);
    emit(
      ChatSearchLoaded(events: searchedEvents.toList()),
    );
  }
}
