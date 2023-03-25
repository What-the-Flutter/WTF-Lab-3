import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../models/models.dart';

class DatabaseProvider {
  static const chatsRoot = 'chats';
  static const eventsRoot = 'events';
  static const categoriesRoot = 'categories';
  static const tagsRoot = 'tags';

  final _chatsSubject = BehaviorSubject<List<Chat>>();
  final _eventsSubject = BehaviorSubject<List<Event>>();

  final User? user;

  DatabaseProvider({
    required this.user,
  }) {
    _initConnection(
      tableName: chatsRoot,
      subject: _chatsSubject,
      fromJson: Chat.fromJson,
    );
    _initConnection(
      tableName: eventsRoot,
      subject: _eventsSubject,
      fromJson: Event.fromJson,
    );
  }

  void _initConnection<T>({
    required String tableName,
    required BehaviorSubject<List<T>> subject,
    required T Function(JsonMap) fromJson,
  }) {
    final ref =
        FirebaseDatabase.instance.ref('/users/${user?.uid}/$tableName');

    ref.onValue.listen(
      (event) {
        final rawData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (rawData == null) {
          subject.add([]);
          return;
        }

        final jsonList =
            rawData.values
                .map((e) => e as Map<Object?, Object?>);

        var objects = <T>[];
        for (final rawObject in jsonList) {
          final json = rawObject.map(
            (key, value) => MapEntry(key.toString(), value),
          );

          objects.add(fromJson(json));
        }

        subject.add(objects);
      },
    );
  }

  Future<List<JsonMap>> read<T>({
    required String tableName,
  }) async {
    final snapshot = await FirebaseDatabase.instance
        .ref('/users/${user?.uid}/$tableName')
        .get();

    if (snapshot.exists) {
      var objects = <JsonMap>[];

      for (final firebaseObject in snapshot.children) {
        final rawData = firebaseObject.value as Map<dynamic, dynamic>;
        final json =
            rawData.map((key, value) => MapEntry(key.toString(), value));

        objects.add(json);
      }

      return objects;
    } else {
      return [];
    }
  }

  Future<void> add({
    required JsonMap json,
    required String tableName,
  }) async {
    final ref = FirebaseDatabase.instance
        .ref('/users/${user?.uid}/$tableName/${json['id']}');

    await ref.set(json);
  }

  Future<void> delete({
    required String id,
    required String tableName,
  }) async {
    await FirebaseDatabase.instance
        .ref('users/${user?.uid}/$tableName/$id')
        .remove();
  }

  Stream<List<Chat>> get chatsStream => _chatsSubject.stream;
  Stream<List<Event>> get eventsStream => _eventsSubject.stream;
}
