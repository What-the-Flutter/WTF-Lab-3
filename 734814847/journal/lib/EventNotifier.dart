import 'package:flutter/material.dart';

import 'models/chat.dart';
import 'widgets/event_widget.dart';

class EventsNotifier with ChangeNotifier {
  List<Chat> chats = <Chat>[];

  void addChat(Chat chat) {
    chats.add(chat);
    notifyListeners();
  }

  void deleteEvents (Chat chat) {
    for (var chat_ in chats) {
      if (chat_.name == chat.name) {
        for (var event in chat_.selectedEvents){
          chat_.events.remove(event);
        }
        chat_.selectedEvents.clear();
        return;
      }
    }
  }

  bool selectionChatHandler(Chat chat){
    for (var chat_ in chats) {
      if (chat_.name == chat.name) {
        return chat_.selectedEvents.isNotEmpty;
      }
    }
    return false;
  }

  void selectionProcessHandler(EventWidget eventWidget) {
    for (var chat in chats) {
      if (chat.events.contains(eventWidget)) {
        for (var event in chat.events) {
          if (event is EventWidget) {
            event.event.selectionProcess = true;
          }
        }
      }
      eventWidget.event.isSelected = true;
      chat.selectedEvents.add(eventWidget);
      notifyListeners();
    }
  }

  void selectedEvent(EventWidget eventWidget) {
    for (var chat in chats) {
      if (chat.events.contains(eventWidget)) {
        if (eventWidget.event.isSelected) {
          chat.selectedEvents.remove(eventWidget);
          if (chat.selectedEvents.isEmpty) {
            for (var event in chat.events) {
              if (event is EventWidget) {
                event.event.selectionProcess = false;
              }
            }
          }
        } else {
          chat.selectedEvents.add(eventWidget);
        }
      }
    }
    eventWidget.event.isSelected = !eventWidget.event.isSelected;
    notifyListeners();
  }
}
