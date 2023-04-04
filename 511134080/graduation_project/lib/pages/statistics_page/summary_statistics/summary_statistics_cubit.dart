import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/event.dart';
import '../../../repositories/event_repository.dart';

part 'summary_statistics_state.dart';

class SummaryStatisticsCubit extends Cubit<SummaryStatisticsState> {
  final EventRepository _eventsRepository;
  late final StreamSubscription<List<Event>> _eventsSubscription;

  SummaryStatisticsCubit({required EventRepository eventsRepository})
      : _eventsRepository = eventsRepository,
        super(SummaryStatisticsState()) {
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
