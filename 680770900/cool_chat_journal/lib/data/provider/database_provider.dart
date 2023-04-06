import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../json_kit.dart';
import '../models/models.dart';

class DatabaseProvider {
  static const chatsRoot = 'chats';
  static const eventsRoot = 'events';
  static const categoriesRoot = 'categories';
  static const tagsRoot = 'tags';

  final _chatsSubject = BehaviorSubject<List<Chat>>();
  final _eventsSubject = BehaviorSubject<List<Event>>();
  final _categoriesSubject = BehaviorSubject<List<Category>>();
  final _tagsSubject = BehaviorSubject<List<Tag>>();

  final User user;

  DatabaseProvider({
    required this.user,
    List<JsonMap>? defaultJsonCategories,
  }) {
    _initConnection<Chat>(
      tableName: chatsRoot,
      subject: _chatsSubject,
      fromJson: Chat.fromJson,
    );
    _initConnection<Event>(
      tableName: eventsRoot,
      subject: _eventsSubject,
      fromJson: Event.fromJson,
    );
    _initConnection<Category>(
      tableName: categoriesRoot,
      subject: _categoriesSubject,
      fromJson: Category.fromJson,
      defaultValues: defaultJsonCategories,
    );
    _initConnection<Tag>(
      tableName: tagsRoot,
      subject: _tagsSubject,
      fromJson: Tag.fromJson,
    );
  }

  void _initConnection<T>({
    required String tableName,
    required BehaviorSubject<List<T>> subject,
    required T Function(JsonMap) fromJson,
    List<JsonMap>? defaultValues,
  }) {
    final ref = FirebaseDatabase.instance.ref('/users/${user.uid}/$tableName');

    ref.onValue.listen(
      (event) {
        final rawData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (rawData == null) {
          if (defaultValues != null) {
            _setDefaultValues(
              tableName: ref.path,
              values: defaultValues,
            );

            subject.add(defaultValues.map(fromJson).toList());
          } else {
            subject.add([]);
          }

          return;
        }

        final jsonList = rawData.values.map((e) => e as Map<Object?, Object?>);

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

  Future<void> _setDefaultValues({
    required String tableName,
    required Iterable<JsonMap> values,
  }) async {
    final ref = FirebaseDatabase.instance.ref(tableName);

    for (final json in values) {
      await ref.child(json['id']).set(json);
    }
  }

  Future<List<JsonMap>> read<T>({
    required String tableName,
  }) async {
    final snapshot = await FirebaseDatabase.instance
        .ref('/users/${user.uid}/$tableName')
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
        .ref('/users/${user.uid}/$tableName/${json['id']}');

    await ref.set(json);
  }

  Future<void> delete({
    required String id,
    required String tableName,
  }) async {
    await FirebaseDatabase.instance
        .ref('users/${user.uid}/$tableName/$id')
        .remove();
  }

  Stream<List<Chat>> get chatsStream => _chatsSubject.stream;
  Stream<List<Event>> get eventsStream => _eventsSubject.stream;
  Stream<List<Category>> get categoriesStream => _categoriesSubject.stream;
  Stream<List<Tag>> get tagsStream => _tagsSubject.stream;
}
