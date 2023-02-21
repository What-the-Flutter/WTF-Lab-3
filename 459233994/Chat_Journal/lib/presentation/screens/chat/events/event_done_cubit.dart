import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';
import 'event_done_state.dart';

class EventDoneCubit extends Cubit<EventDoneState> {
  EventDoneCubit(Event event) : super(EventNotDone()) {
    if (event.isDone) {
      emit(EventDone());
    }
  }

  Event changeDoneState(Event event) {
    event = event.updateDoneState(event, !event.isDone);
    (state is EventDone) ? emit(EventNotDone()) : emit(EventDone());
    return event;
  }
}
