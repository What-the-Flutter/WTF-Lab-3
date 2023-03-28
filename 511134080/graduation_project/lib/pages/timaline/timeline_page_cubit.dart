import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hashtagable/functions.dart';

import '../../models/event.dart';
import '../../repositories/event_repository.dart';

part 'timeline_page_state.dart';

class TimelinePageCubit extends Cubit<TimelinePageState> {
  final EventRepository eventsRepository;
  late final StreamSubscription<List<Event>> eventsSubscription;

  TimelinePageCubit({required this.eventsRepository})
      : super(TimelinePageState()) {
    initSubscription();
  }

  void initSubscription() {
    eventsSubscription = eventsRepository.eventsStream.listen(
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
  }

  Future<void> init() async {
    final events = await eventsRepository.receiveAllEvents();
    emit(
      state.copyWith(
        newEvents: events,
      ),
    );
  }

  void toggleFavouriteMode() {
    emit(
      state.copyWith(
        showingFavourites: !state.isShowingFavourites,
      ),
    );
  }
}
