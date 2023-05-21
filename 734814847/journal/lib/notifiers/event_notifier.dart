import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/chat.dart';
import '../models/event.dart';

class EventsNotifier with ChangeNotifier {
  List<Chat> chats = <Chat>[
    Chat(
      name: 'Travel',
      key: UniqueKey(),
      icon: icons[1],
    ),
    Chat(
      name: 'Family',
      key: UniqueKey(),
      icon: icons[3],
    ),
    Chat(
      name: 'Sports',
      key: UniqueKey(),
      icon: icons[2],
    )
  ];

  void addChat(Chat chat) {
    chats.add(chat);
  }

  void deleteChat(Chat chat) {
    chats.remove(chat);
  }

  void deleteEvents(Chat chat) {
    chat.events.removeWhere((element) => element.isSelected);
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    notifyListeners();
  }

  Future copySelected(Chat chat) async {
    var result = '';
    for (var event in chat.events.where((element) => element.isSelected)) {
      result += '${event.text}\n';
      event.isSelected = false;
    }
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    notifyListeners();
    await Clipboard.setData(ClipboardData(text: result));
  }

  void selectionProcessHandler(Event event_) {
    for (var chat in chats) {
      if (chat.events.contains(event_)){
        for (var event in chat.events) {
          event.isSelectionProcess = true;
        }
        event_.isSelected = true;
        notifyListeners();
        return;
      }
    }
  }

  void selectedEvent(Event event_) {
    event_.isSelected = !event_.isSelected;
    for (var chat in chats) {
      if (chat.events.contains(event_)) {
        if (!event_.isSelected) {
          if (chat.events.where((element) => element.isSelected).isEmpty) {
            for (var event in chat.events) {
              event.isSelectionProcess = false;
            }
          }
        }
      }
    }

    notifyListeners();
    return;
  }

  void changeEvent(Chat chat, String text) {
    var index = chat.events.indexOf(chat.events.where((element) => element.isSelected).first);
    chat.events[index].text = text;
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    notifyListeners();
    return;
  }

  void errorChangeEvent(Chat chat) {
    var index = chat.events.indexOf(chat.events.where((element) => element.isSelected).first);
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    notifyListeners();
    return;
  }

  void favouriteEvent(Event event_) {
    for (var chat in chats) {
      if (chat.events.contains(event_)) {
        event_.isFavourite = !event_.isFavourite;
        notifyListeners();
        return;
      }
    }
  }
}
