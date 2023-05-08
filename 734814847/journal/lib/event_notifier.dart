import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/chat.dart';
import 'models/event.dart';
import 'widgets/event_widget.dart';

class EventsNotifier with ChangeNotifier {
  List<Chat> chats = <Chat>[];

  void addChat(Chat chat) {
    chats.add(chat);
    notifyListeners();
  }

  void deleteEvents (Chat chat) {
    for (var event in chat.selectedEvents){
      chat.events.remove(event);
    }
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    chat.selectedEvents.clear();
    notifyListeners();
  }

  Future copySelected (Chat chat) async {
    var result = '';
    for (var event in chat.selectedEvents){
      result += '${event.text}\n';
      event.isSelected = false;
    }
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    chat.selectedEvents.clear();
    notifyListeners();
    await Clipboard.setData(ClipboardData(text: result));
  }

  List<Event> selectionChatHandler(Chat chat){
    for (var chat_ in chats) {
      if (chat_.name == chat.name) {
        return chat_.selectedEvents;
      }
    }
    return [];
  }

  void selectionProcessHandler(Event event_) {
    for (var chat in chats) {
      if (chat.events.contains(event_)) {
        for (var event in chat.events) {
          event.isSelectionProcess = true;
        }
      }
      event_.isSelected = true;
      chat.selectedEvents.add(event_);
      notifyListeners();
      return;
    }
  }

  void selectedEvent(Event event_) {
    for (var chat in chats) {
      if (chat.events.contains(event_)) {
        if (event_.isSelected) {
          chat.selectedEvents.remove(event_);
          if (chat.selectedEvents.isEmpty) {
            for (var event in chat.events) {
              event.isSelectionProcess = false;
            }
          }
        } else {
          chat.selectedEvents.add(event_);
        }
      }
    }
    event_.isSelected = !event_.isSelected;
    notifyListeners();
    return;
  }

  void changeEvent(Chat chat, String text) {
    var index = chat.events.indexOf(chat.selectedEvents.first);
    chat.events[index].text = text;
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    chat.selectedEvents.clear();
    notifyListeners();
    return;
  }

  void errorChangeEvent (Chat chat){
    var index = chat.events.indexOf(chat.selectedEvents.first);
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    chat.selectedEvents.clear();
    notifyListeners();
    return;
  }
}
