import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/event.dart';
import '../../../repositories/event_repository.dart';

part 'label_statistics_state.dart';

class LabelStatisticsCubit extends Cubit<LabelStatisticsState> {
  final EventRepository _eventsRepository;
  late final StreamSubscription<List<Event>> _eventsSubscription;

  LabelStatisticsCubit({required EventRepository eventsRepository})
      : _eventsRepository = eventsRepository,
        super(LabelStatisticsState()) {
    _initSubscription();
  }

  void _initSubscription() {
    _eventsSubscription = _eventsRepository.eventsStream.listen(
      (events) async {
        emit(
          state.copyWith(
            newEvents: events,
          ),
        );
      },
    );
  }
}
