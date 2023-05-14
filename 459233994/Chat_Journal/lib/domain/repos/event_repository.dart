import 'dart:async';

import '../entities/event.dart';

abstract class EventRepository{
  Future<List<Event>> getEvents(String chatId);

  Future<void> insertEvent(Event event);

  Future<void> changeEvent(Event event);

  Future<void> deleteEvent(Event event);

  Future<StreamSubscription> initListener(String chatId);

  Future<List<Event>> getEventsForTimeLine();
}