import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/models/chat_model.dart';

import '../models/event_card_model.dart';

class EventsProvider with ChangeNotifier {
  final _chats = <ChatModel>[
    ChatModel(
      icon: const Icon(
        Icons.flight_takeoff,
        size: 32,
        color: Colors.white,
      ),
      title: 'Travel',
      id: UniqueKey(),
    ),
    ChatModel(
      icon: const Icon(
        Icons.weekend_outlined,
        color: Colors.white,
        size: 32,
      ),
      title: 'Family',
      id: UniqueKey(),
    ),
    ChatModel(
      icon: const Icon(
        Icons.fitness_center,
        color: Colors.white,
        size: 32,
      ),
      title: 'Sports',
      id: UniqueKey(),
    ),
  ];

  List<ChatModel> get chats => _chats;

  void updateLastEvent(ChatModel chat) {
    if (chat.allCards.isNotEmpty) {
      chat.lastEventTitle = chat.allCards.last.title;
    } else {
      chat.lastEventTitle = 'No events. Click here to create one';
    }
    notifyListeners();
  }

  // void addChat(ChatModel chat) {
  //   _chats.add(chat);
  //   notifyListeners();
  // }

  void manageFavouriteEventCard(EventCardModel cardModel) {
    for (var chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        if (cardModel.isFavourite) {
          chat.favouriteCards.remove(cardModel);
        } else {
          chat.favouriteCards.add(cardModel);
        }
        cardModel.isFavourite = !cardModel.isFavourite;
        notifyListeners();
        return;
      }
    }
  }

  void turnOnSelectionMode(EventCardModel cardModel) {
    for (var chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        for (var card in chat.allCards) {
          card.isSelectionMode = true;
        }
        cardModel.isSelected = true;
        chat.selectedCards.add(cardModel);
        notifyListeners();
        return;
      }
    }
  }

  void manageSelectedEvent(EventCardModel cardModel) {
    for (var chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        if (cardModel.isSelected) {
          chat.selectedCards.remove(cardModel);
          if (chat.selectedCards.isEmpty) {
            for (var card in chat.allCards) {
              card.isSelectionMode = false;
            }
          }
        } else {
          chat.selectedCards.add(cardModel);
        }
        cardModel.isSelected = !cardModel.isSelected;
        notifyListeners();
        return;
      }
    }
  }

  void manageFavouritesFromSelectionMode(ChatModel chat) {
    for (var card in chat.selectedCards) {
      if (card.isFavourite) {
        chat.favouriteCards.remove(card);
      } else {
        chat.favouriteCards.add(card);
      }
      card.isFavourite = !card.isFavourite;
      card.isSelected = false;
    }
    for (var card in chat.allCards) {
      card.isSelectionMode = false;
    }
    chat.selectedCards.clear();
    notifyListeners();
  }

  void cancelSelectionMode(ChatModel chat) {
    for (var card in chat.selectedCards) {
      card.isSelected = false;
    }
    for (var card in chat.allCards) {
      card.isSelectionMode = false;
    }
    chat.selectedCards.clear();
    notifyListeners();
  }

  void deleteSelectedCards(ChatModel chat) {
    for (var card in chat.selectedCards) {
      chat.allCards.remove(card);
    }
    for (var card in chat.allCards) {
      card.isSelectionMode = false;
    }
    chat.selectedCards.clear();
    updateLastEvent(chat);
    notifyListeners();
  }

  Future<void> copySelectedCards(ChatModel chat) async {
    String text = '';
    for (var card in chat.selectedCards) {
      text += '${card.title}\n';
      card.isSelected = false;
    }
    for (var card in chat.allCards) {
      card.isSelectionMode = false;
    }
    chat.selectedCards.clear();
    notifyListeners();
    await Clipboard.setData(ClipboardData(text: text));
  }

  void editSelectedEventCard(ChatModel chat, newTitle) {
    var selectedCard = chat.selectedCards.first;
    selectedCard.title = newTitle;
    selectedCard.isSelected = false;
    for (var card in chat.allCards) {
      card.isSelectionMode = false;
    }
    chat.selectedCards.clear();
    notifyListeners();
  }

  void migrateSelectedEventCards(chat) {}
}
