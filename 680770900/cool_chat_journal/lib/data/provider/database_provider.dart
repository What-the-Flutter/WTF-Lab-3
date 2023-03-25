import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/models.dart';

class DatabaseProvider {
  static const chatsRoot = 'chats';
  static const eventsRoot = 'events';
  static const categoriesRoot = 'categories';
  static const tagsRoot = 'tags';

  final _chatsStreamController = StreamController<List<Chat>>();

  final User? user;

  DatabaseProvider({
    required this.user,
  }) {
    _initConnection(
      tableName: chatsRoot,
      controller: _chatsStreamController,
      fromJson: Chat.fromJson,
    );
  }

  void _initConnection<T>({
    required String tableName,
    required StreamController<List<T>> controller,
    required T Function(JsonMap) fromJson,
  }) {
    final ref =
        FirebaseDatabase.instance.ref('/users/${user?.uid}/$tableName');

    ref.onValue.listen(
      (event) {
        final rawData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (rawData == null) {
          controller.add([]);
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

        controller.add(objects);
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

  Stream<List<Chat>> get chatsStream => _chatsStreamController.stream;
}
