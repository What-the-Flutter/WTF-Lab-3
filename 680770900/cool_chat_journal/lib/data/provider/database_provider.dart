import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/models.dart';

class DatabaseProvider {
  static const chatsRoot = 'chats';
  static const eventsRoot = 'events';
  static const categoriesRoot = 'categories';

  final User? user;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final _chatsStreamController = StreamController<List<Chat>>.broadcast();
  final _eventsStreamController = StreamController<List<Event>>.broadcast();
  final _categoriesStreamController = StreamController<List<Category>>.broadcast();

  DatabaseProvider({
    required this.user,
  }) {
    // final userRoot = 'users/${user?.uid}';

    // _initConnection<Chat>(
    //   refPath: '$userRoot/$chatsRoot',
    //   streamController: _chatsStreamController,
    //   fromJson: Chat.fromJson,
    // );

    // _initConnection<Event>(
    //   refPath: '$userRoot/$chatsRoot',
    //   streamController: _eventsStreamController,
    //   fromJson: Event.fromJson,
    // );

    // _initConnection<Category>(
    //   refPath: '$userRoot/$chatsRoot',
    //   streamController: _categoriesStreamController,
    //   fromJson: Category.fromJson,
    // );
  }

  void _initConnection<T>({
    required String refPath,
    required StreamController<List<T>> streamController,
    required T Function(JsonMap) fromJson,
  }) {
    final ref = FirebaseDatabase.instance.ref(refPath);
    ref.onValue.listen((event) {
      var values = <T>[];

      for (final firebaseObject in event.snapshot.children) {
        final rawData = firebaseObject.value as Map<dynamic, dynamic>;
        final json = rawData.map((key, value) => MapEntry(key.toString(), value));
        
        print('INFO: json $json');
        values.add(fromJson(json));
      }

      streamController.add(values);
    });
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
        final json = rawData
          .map((key, value) => MapEntry(key.toString(), value));

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

  Stream<List<Chat>> get chatsStream => 
    _chatsStreamController.stream; 

  Stream<List<Event>> get eventsStream => 
    _eventsStreamController.stream; 

  Stream<List<Category>> get categoriesStream => 
    _categoriesStreamController.stream; 
}