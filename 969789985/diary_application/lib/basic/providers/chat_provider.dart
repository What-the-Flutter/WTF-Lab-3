import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'chat_list_provider.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider({
    required this.chatListProvider,
    required this.chatId,
  }) {
    for (final message in chat.messages) {
      selectedItems[message.id] = false;
    }
  }

  final ChatListProvider chatListProvider;
  final int chatId;

  ChatModel get chat => chatListProvider.chatById(chatId);

  IList<MessageModel> get messages => chat.messages;

  List<MessageModel> favoriteMessages = List.empty(growable: true);

  final MessageModel _message = MessageModel();

  final Map<int, bool> selectedItems = {};
  var _isSelectMode = false;
  var _selectedItemsCount = 0;
  var _isEditMode = false;
  var _isFavoriteMode = false;

  bool get isSelectMode => _isSelectMode;

  bool get isEditMode => _isEditMode;

  int get selectedItemsCount => _selectedItemsCount;

  bool get isFavoriteMode => _isFavoriteMode;

  MessageModel get message => _message;

  void add(MessageModel message) {
    if (!_update(message)) {
      chatListProvider.update(
        chat.copyWith(
          messages: chat.messages.add(message),
        ),
      );
    }

    selectedItems[message.id] = false;

    notifyListeners();
  }

  void remove() {
    if (_isSelectMode) {
      chatListProvider.update(
        chat.copyWith(
          messages:
              chat.messages.removeWhere((el) => selectedItems[el.id] == true),
        ),
      );
      selectedItems.removeWhere((key, value) => selectedItems[key] == true);
      notifyListeners();
    } else {}
  }

  bool _update(MessageModel message) {
    var index = messages.indexWhere((m) => m.id == message.id);
    if (index == -1) return false;

    chatListProvider.update(
      chat.copyWith(
        messages: chat.messages.updateById([message], (item) => item.id),
      ),
    );

    return true;
  }

  void startEditMode() {
    _isEditMode = true;
    notifyListeners();
  }

  void endEditMode() {
    _isEditMode = false;
  }

  void selectMessage(int index) {
    _isSelectMode = true;
    if (selectedItems[index]!) {
      _selectedItemsCount--;
      selectedItems[index] = false;
    } else {
      _selectedItemsCount++;
      selectedItems[index] = true;
    }
    notifyListeners();
  }

  void unselectAll() {
    selectedItems.updateAll((key, value) => value = false);
    _isSelectMode = false;
    _selectedItemsCount = 0;
    notifyListeners();
  }

  void startFavoriteMode() {
    _isFavoriteMode = true;
    notifyListeners();
  }

  void endFavoriteMode() {
    _isFavoriteMode = false;
    notifyListeners();
  }

  bool hasFavorites() {
    var m = messages.firstWhere((element) => element.isFavorite,
        orElse: MessageModel.new);

    if(m.isFavorite) {
      return true;
    } else {
      return false;
    }
  }

  void addToFavorites(MessageModel message) {
    _update(
      message.copyWith(
        isFavorite: true,
      ),
    );
    notifyListeners();
  }

  void removeFromFavorites(MessageModel message) {
    _update(
      message.copyWith(
        isFavorite: false,
      ),
    );
    notifyListeners();
  }

  void addSelectedToFavorites() {
    for (final message in messages) {
      if (selectedItems[message.id]!) {
        _update(
          message.copyWith(isFavorite: true),
        );
        favoriteMessages.add(message);
      }
    }
    unselectAll();
  }

  void removeSelectedFromFavorites() {
    for (final message in messages) {
      if (selectedItems[message.id]!) {
        _update(
          message.copyWith(isFavorite: false),
        );
        favoriteMessages.add(message);
      }
    }
    unselectAll();
  }

  void copySelectedToBuffer() async {
    var mes = messages.reversed.where((element) => selectedItems[element.id]!);

    var text = mes.sortedReversed().map((e) => e.messageText).join('\n');

    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

}
