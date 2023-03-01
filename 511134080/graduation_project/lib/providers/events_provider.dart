import 'package:flutter/material.dart';
import 'package:graduation_project/models/chat_model.dart';

import '../entities/event_card.dart';

class EventsProvider with ChangeNotifier {
  var chats = <ChatModel>[];

  void addChat(ChatModel chat) {
    chats.add(chat);
    notifyListeners();
  }

  void manageFavouriteEventCard(EventCard eventCard) {
    for (var chat in chats) {
      if (chat.allCards.contains(eventCard)) {
        if (eventCard.cardModel.isFavourite) {
          chat.favouriteCards.remove(eventCard);
        } else {
          chat.favouriteCards.add(eventCard);
        }
        eventCard.cardModel.isFavourite = !eventCard.cardModel.isFavourite;
        notifyListeners();
        return;
      }
    }
  }

  void turnOnSelectionMode(EventCard eCard) {
    for (var chat in chats) {
      if (chat.allCards.contains(eCard)) {
        for (var card in chat.allCards) {
          if (card is EventCard) {
            var eventCard = card;
            eventCard.cardModel.isSelectionMode = true;
          }
        }
        eCard.cardModel.isLongPress = true;
        chat.selectedCards.add(eCard);
        notifyListeners();
        return;
      }
    }
  }

  void manageSelectedEvent(EventCard eventCard) {
    for (var chat in chats) {
      if (chat.allCards.contains(eventCard)) {
        if (eventCard.cardModel.isLongPress) {
          chat.selectedCards.remove(eventCard);
          if (chat.selectedCards.isEmpty) {
            for (var card in chat.allCards) {
              if (card is EventCard) {
                var eCard = card;
                eCard.cardModel.isSelectionMode = false;
              }
            }
          }
        } else {
          chat.selectedCards.add(eventCard);
        }
      }
    }
    eventCard.cardModel.isLongPress = !eventCard.cardModel.isLongPress;
    notifyListeners();
  }
}
