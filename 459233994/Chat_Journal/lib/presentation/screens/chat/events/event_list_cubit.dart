import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';

class EventListCubit extends Cubit<List<Event>>{
  EventListCubit(List<Event> events) : super(events);

  void updateEvent(Event oldEvent, Event changedEvent){
    var events = state;
    events[events.indexOf(oldEvent)] = changedEvent;
    emit(events);
  }

  void deleteEvent(Event event){
    var events = state;
    events.remove(event);
    emit(events);
  }
}