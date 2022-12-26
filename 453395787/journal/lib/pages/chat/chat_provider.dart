import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../chat_repository.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider(this.chat);

  final inputTextController = TextEditingController();
  final Chat chat;
  final _selected = <int>{};
  var _message = Message();
  var _isEditMode = false;
  var _canBeSended = false;

  String get name => chat.name;
  QueueList<Message> get messages => chat.messages;
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

    for (final m in selectedMessages) {
      if (m.isFavorite) {
        staredAmount++;
      } else {
        otherAmount++;
      }
    }

    return otherAmount >= staredAmount;
  }

  Message get message => _message;
  set message(Message message) {
    _message = message;
    notifyListeners();
  }


  bool get canBeSended => _canBeSended;
  set canBeSended(bool value) {
    _canBeSended = value;
    notifyListeners();
  }

  void add(Message message) {
    if (!_update(message)) {
      messages.addFirst(message);
    }
    notifyListeners();
  }

  void remove(Message message) {
    messages.remove(message);
    notifyListeners();
  }
  
  void removeSelected() {
    messages.removeWhere((m) => selected.contains(m.id));
    selected.clear();
    notifyListeners();
  }

  bool _update(Message message) {
    var index = messages.indexWhere((m) => m.id == message.id);
    if (index == -1) return false;
    messages[index] = message;
    return true;
  }

  void startEditMode(Message message) {
    _isEditMode = true;
    _selected.add(message.id);
    _message = message;
    inputTextController.text = message.text;
    notifyListeners();
  }

  void startEditModeForSelected() {
    var message = messages.firstWhere((e) => e.id == _selected.first);
    startEditMode(message);
  }

  void endEditMode() {
    _isEditMode = false;
    _selected.clear();
    message = Message();
    inputTextController.text = '';
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
    Fluttertoast.showToast(msg: 'Text copied to clipboard');
    await Clipboard.setData(ClipboardData(text: message.text));
  }

  void copySelectedToClipboard() async {
    Fluttertoast.showToast(msg: 'Text copied to clipboard');
    final text = selectedMessages.map((e) => e.text).join('\n');
    await Clipboard.setData(ClipboardData(text: text));
  }

  void addToFavorites(Message message) {
    _update(message.copyWith(isFavorite: true));
    notifyListeners();
  }

  void removeFromFavorites(Message message) {
    _update(message.copyWith(isFavorite: false));
    notifyListeners();
  }

  void addSelectedToFavorites() {
    final selected = selectedMessages;
    for (final m in selected) {
      _update(m.copyWith(isFavorite: true));
    }
    notifyListeners();
  }

  void removeSelectedFromFavorites() {
    final selected = selectedMessages;
    for (final m in selected) {
      _update(m.copyWith(isFavorite: false));
    }
    notifyListeners();
  }
}
