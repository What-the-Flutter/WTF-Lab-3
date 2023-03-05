import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/models/chat_model.dart';

import '../models/event_card_model.dart';

class EventsProvider with ChangeNotifier {
  final _chats = <ChatModel>[
    ChatModel(
      iconId: 0,
      title: 'Travel',
      id: UniqueKey(),
      allCards: const [],
    ),
    ChatModel(
      iconId: 1,
      title: 'Family',
      id: UniqueKey(),
      allCards: const [],
    ),
    ChatModel(
      iconId: 2,
      title: 'Sports',
      id: UniqueKey(),
      allCards: const [],
    ),
  ];

  List<ChatModel> get chats => _chats;

  void updateLastEvent(ChatModel chat) {
    if (chat.allCards.isNotEmpty) {
      chat = chat.copyWith(newLastEventTitle: chat.allCards.last.title);
    } else {
      chat = chat.copyWith(
          newLastEventTitle: 'No events. Click here to create one');
    }
    notifyListeners();
  }

  void manageFavouriteEventCard(EventCardModel cardModel) {
    for (final chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        cardModel = cardModel.copyWith(
          isFavourite: !cardModel.isFavourite,
        );
        notifyListeners();
        return;
      }
    }
  }

  void turnOnSelectionMode(EventCardModel cardModel) {
    for (final chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        for (var card in chat.allCards) {
          card = card.copyWith(
            isSelectionMode: true,
          );
        }
        cardModel = cardModel.copyWith(
          isSelected: true,
        );
        notifyListeners();
        return;
      }
    }
  }

  void manageSelectedEvent(EventCardModel cardModel) {
    for (final chat in _chats) {
      if (chat.allCards.contains(cardModel)) {
        if (cardModel.isSelected) {
          if (chat.allCards.where((element) => element.isSelected).isEmpty) {
            for (var card in chat.allCards) {
              card = card.copyWith(
                isSelectionMode: false,
              );
            }
          }
        }
        cardModel = cardModel.copyWith(
          isSelected: !cardModel.isSelected,
        );
        notifyListeners();
        return;
      }
    }
  }

  void manageFavouritesFromSelectionMode(ChatModel chat) {
    for (var card in chat.allCards.where((element) => element.isSelected)) {
      card = card.copyWith(
        isFavourite: !card.isFavourite,
        isSelected: false,
      );
    }
    for (var card in chat.allCards) {
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    notifyListeners();
  }

  void cancelSelectionMode(ChatModel chat) {
    for (var card in chat.allCards.where((element) => element.isSelected)) {
      card = card.copyWith(
        isSelected: false,
      );
    }
    for (var card in chat.allCards) {
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    notifyListeners();
  }

  void deleteSelectedCards(ChatModel chat) {
    for (final card in chat.allCards.where((element) => element.isSelected)) {
      chat.allCards.remove(card);
    }
    for (var card in chat.allCards) {
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    updateLastEvent(chat);
    notifyListeners();
  }

  Future<void> copySelectedCards(ChatModel chat) async {
    String text = '';
    for (var card in chat.allCards.where((element) => element.isSelected)) {
      text += '${card.title}\n';
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    for (var card in chat.allCards) {
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    notifyListeners();
    await Clipboard.setData(ClipboardData(text: text));
  }

  void editSelectedEventCard(ChatModel chat, newTitle) {
    var selectedCard =
        chat.allCards.where((element) => element.isSelected).first;

    selectedCard = selectedCard.copyWith(
      newTitle: newTitle,
      isSelected: false,
    );

    for (var card in chat.allCards) {
      card = card.copyWith(
        isSelectionMode: false,
      );
    }
    notifyListeners();
  }

  void migrateSelectedEventCards(chat) {}
}
