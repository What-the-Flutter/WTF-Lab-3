import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'chats_observer.dart';

void main() {
  Bloc.observer = const ChatsObserver();
  runApp(const CoolChatJournalApp());
}
