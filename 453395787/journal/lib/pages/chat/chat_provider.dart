import 'dart:core';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../chat_list_provider.dart';
import '../../model/chat.dart';
import '../../model/message.dart';
import '../../utils/extensions.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider({
    required this.chatListProvider,
    required this.chatId,
  });

  final ChatListProvider chatListProvider;
  final int chatId;

  Chat get chat => chatListProvider.findById(chatId);
  final _selected = <int>{};
  var _message = Message();
  var _isEditMode = false;
  var _canBeSended = false;

  String get name => chat.name;
  IList<Message> get messages => chat.messages;
  Set<int> get selected => _selected;

  Iterable<Message> get selectedMessages =>
      messages.where((e) => _selected.contains(e.id));

  bool get hasSelected => _selected.isNotEmpty;
  bool get isInputImagesEmpty => _message.images.isEmpty;
  bool get isInputTextEmpty => _message.text.isEmpty;
  bool get isSingleSelected => _selected.length == 1;
  bool get isEditMode => _isEditMode;

  bool get canAddSelectedToFavorites {
    var staredAmount = 0;
    var otherAmount = 0;

    for (var m in selectedMessages) {
      if (m.isFavorite) {
        staredAmount++;
      } else {
        otherAmount++;
      }
    }

    return otherAmount >= staredAmount;
  }

  Message get message => _message;

  bool get canBeSended => _canBeSended;
  set canBeSended(bool value) {
    _canBeSended = value;
    notifyListeners();
  }

  String? _initialText;
  String? get initialText {
    var buffer = _initialText;
    _initialText = null;
    return buffer;
  }

  List<Object> get messagesWithDates {
    var lastDate = messages.first.dateTime;
    var list = <Object>[lastDate.formatMonthDay, messages.first];

    for (var message in messages) {
      if (!message.dateTime.isSameDay(lastDate)) {
        list.add(message.dateTime.formatMonthDay);
        lastDate = message.dateTime;
      }
      list.add(message);
    }

    return list;
  }

  void add(Message message) {
    if (!_update(message)) {
      chatListProvider.update(
        chat.copyWith(
          messages: chat.messages.add(message),
        ),
      );
    }
    notifyListeners();
  }

  void remove(Message message) {
    messages.remove(message);
    chatListProvider.update(
      chat.copyWith(
        messages: chat.messages.remove(message),
      ),
    );
    notifyListeners();
  }

  void removeSelected() {
    chatListProvider.update(
      chat.copyWith(
        messages: chat.messages.removeWhere(
          (e) => selected.contains(e.id),
        ),
      ),
    );
    selected.clear();
    notifyListeners();
  }

  bool _update(Message message) {
    var index = messages.indexWhere((m) => m.id == message.id);
    if (index == -1) return false;

    chatListProvider.update(
      chat.copyWith(
        messages: chat.messages.updateById([message], (item) => item.id),
      ),
    );

    return true;
  }

  void startEditMode(Message message) {
    _isEditMode = true;
    _selected.add(message.id);
    _message = message;
    _initialText = message.text;
    notifyListeners();
  }

  void startEditModeForSelected() {
    var message = chat.messages.firstWhere((e) => e.id == _selected.first);
    startEditMode(message);
  }

  void endEditMode() {
    _isEditMode = false;
    _selected.clear();
    _message = Message();
    _initialText = '';
    notifyListeners();
  }

  void select(Message message) {
    _selected.add(message.id);
    notifyListeners();
  }

  void unselect(Message message) {
    _selected.remove(message.id);
    notifyListeners();
  }

  void unselectAll() {
    _selected.clear();
    notifyListeners();
  }

  bool isSelected(Message message) => _selected.contains(message.id);

  void toggleSelection(Message message) {
    if (isSelected(message)) {
      unselect(message);
    } else {
      select(message);
    }
  }

  void resetSelected() {
    _selected.clear();
    notifyListeners();
  }

  void copyToClipboard(Message message) async {
    await Clipboard.setData(
      ClipboardData(
        text: message.text,
      ),
    );
  }

  void copySelectedToClipboard() async {
    final text = selectedMessages.map((e) => e.text).join('\n');
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  void addToFavorites(Message message) {
    _update(
      message.copyWith(
        isFavorite: true,
      ),
    );
    notifyListeners();
  }

  void removeFromFavorites(Message message) {
    _update(
      message.copyWith(
        isFavorite: false,
      ),
    );
    notifyListeners();
  }

  void addSelectedToFavorites() {
    final selected = selectedMessages;
    for (var m in selected) {
      _update(
        m.copyWith(
          isFavorite: true,
        ),
      );
    }
    notifyListeners();
  }

  void removeSelectedFromFavorites() {
    final selected = selectedMessages;
    for (var m in selected) {
      _update(
        m.copyWith(
          isFavorite: false,
        ),
      );
    }
    notifyListeners();
  }

  void addImagesToInputMessage(Iterable<String> images) {
    _message = _message.copyWith(
      images: _message.images.addAll(images),
    );
    notifyListeners();
  }

  void setImagesToInputMessage(Iterable<String> images) {
    _message = _message.copyWith(
      images: images.toIList(),
    );
    notifyListeners();
  }

  void removeImageFromSelectedMessage(int index) {
    _message = message.copyWith(
      images: message.images.removeAt(index),
    );
    notifyListeners();
  }

  void clearInputMessage() {
    _message = Message();
    notifyListeners();
  }
}
