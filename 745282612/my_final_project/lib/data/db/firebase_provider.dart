import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/entities/section.dart';

class FirebaseProvider {
  final _database = FirebaseDatabase.instance;
  final _ref = FirebaseDatabase.instance.ref();
  final _storage = FirebaseStorage.instance.ref();
  final User? user;

  FirebaseProvider({required this.user});

  Future<void> addChat(Chat chat) async {
    try {
      await _ref.child(user!.uid).child('chat/${chat.dateCreate.millisecondsSinceEpoch}').set(
            chat.toMap(),
          );
    } catch (e) {
      print(e);
    }
  }

  Future<Event> addEvent(Event event) async {
    final path = event.messageImage;
    late final Event newEvent;
    if (path != null) {
      final file = File(path);
      try {
        await _storage
            .child(user!.uid)
            .child('event/${event.messageTime.millisecondsSinceEpoch}')
            .putFile(file);
        final downloadURL = await FirebaseStorage.instance
            .ref()
            .child(user!.uid)
            .child('event/${event.messageTime.millisecondsSinceEpoch}')
            .getDownloadURL();
        newEvent = event.copyWith(messageImage: downloadURL);
      } catch (e) {
        print(e);
      }
    } else {
      newEvent = event;
    }
    try {
      await _ref
          .child(user!.uid)
          .child('event/${newEvent.messageTime.millisecondsSinceEpoch}')
          .set(newEvent.toMap());
    } catch (e) {
      print(e);
    }
    return newEvent;
  }

  Future<void> addSection(Section section) async {
    try {
      await _ref.child(user!.uid).child('section/${section.id}').set(section.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Section>> getAllSection() async {
    final sectionList = <Section>[];
    final databaseSectionSystem = await _ref.child('section').once();
    for (final sectionElement in databaseSectionSystem.snapshot.children) {
      final map = sectionElement.value as Map<dynamic, dynamic>;
      final section = Section.fromJson(map);
      sectionList.add(section);
    }
    final databaseSectionUser = await _ref.child(user!.uid).child('section').once();
    for (final sectionElement in databaseSectionUser.snapshot.children) {
      final map = sectionElement.value as Map<dynamic, dynamic>;
      final section = Section.fromJson(map);
      sectionList.add(section);
    }
    return sectionList;
  }

  Future<List<Chat>> getAllChat() async {
    final chatList = <Chat>[];
    final databaseChat =
        await _ref.child(user!.uid).child('chat').orderByChild('${ChatField.pin}').once();
    for (final chatElement in databaseChat.snapshot.children) {
      final map = chatElement.value as Map<dynamic, dynamic>;
      final chat = Chat.fromJson(map);
      chatList.add(chat);
    }
    return chatList.reversed.toList();
  }

  Future<List<Event>> getAllEvent() async {
    final eventList = <Event>[];
    final database = await _ref.child(user!.uid).child('event').once();
    for (final eventElement in database.snapshot.children) {
      final map = eventElement.value as Map<dynamic, dynamic>;
      final event = Event.fromJson(map);
      eventList.add(event);
    }
    return eventList;
  }

  Future<void> deleteChat(Chat chat) async {
    try {
      await _ref.child(user!.uid).child('chat/${chat.dateCreate.millisecondsSinceEpoch}').remove();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteEvent(Event event) async {
    try {
      await _ref
          .child(user!.uid)
          .child('event/${event.messageTime.millisecondsSinceEpoch}')
          .remove();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChat(Chat chat) async {
    try {
      await _ref
          .child(user!.uid)
          .child('chat/${chat.dateCreate.millisecondsSinceEpoch}')
          .update(chat.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _ref
          .child(user!.uid)
          .child('event/${event.messageTime.millisecondsSinceEpoch}')
          .update(event.toMap());
    } catch (e) {
      print(e);
    }
  }
}
