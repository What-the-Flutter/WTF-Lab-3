import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hashtagable/functions.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';

part 'timeline_page_state.dart';

class TimelinePageCubit extends Cubit<TimelinePageState> {
  final EventRepository _eventsRepository;
  final ChatRepository _chatsRepository;
  late final StreamSubscription<List<Event>> _eventsSubscription;
  late final StreamSubscription<List<Chat>> _chatsSubscription;

  TimelinePageCubit({
    required EventRepository eventsRepository,
    required ChatRepository chatsRepository,
  })  : _chatsRepository = chatsRepository,
        _eventsRepository = eventsRepository,
        super(TimelinePageState()) {
    initSubscriptions();
  }

  void initSubscriptions() {
    _eventsSubscription = _eventsRepository.eventsStream.listen(
      (events) {
        final tags = <String>{};
        for (final event in events) {
          if (hasHashTags(event.title)) {
            tags.addAll(extractHashTags(event.title));
          }
        }
        emit(
          state.copyWith(
            newEvents: events,
            newTags: tags,
          ),
        );
      },
    );
    _chatsSubscription = _chatsRepository.chatsStream.listen(
      (chats) {
        emit(
          state.copyWith(
            newChats: chats,
          ),
        );
      },
    );
  }

  Future<void> init() async {
    final events = await _eventsRepository.receiveAllEvents();
    emit(
      state.copyWith(
        newEvents: events,
      ),
    );
  }

  void updateEvents(List<Event> events) => emit(
        state.copyWith(
          newEvents: events,
        ),
      );

  void toggleFavouriteMode() {
    emit(
      state.copyWith(
        showingFavourites: !state.isShowingFavourites,
      ),
    );
  }
}
