import 'dart:async';
import 'dart:developer' as dev;

import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

mixin BaseDao<UserDataClass extends DataClass, UserTable extends Table> {

  TableInfo<UserTable, UserDataClass> get table => throw UnimplementedError();

  DatabaseAccessor get accessor => throw UnimplementedError();

  final BehaviorSubject<IList<UserDataClass>> _stream = BehaviorSubject.seeded(
    IList<UserDataClass>([]),
  );

  late StreamSubscription<List<UserDataClass>> _subscription;

  ValueStream<IList<UserDataClass>> get stream => _stream.stream;

  Future<void> init() async {
    _stream.add(await getAll());
    _subscription = accessor.select(table).watch().listen((event) {
      _stream.add(event.toIList());
    });
  }

  Future<void> close() async {
    await _subscription.cancel();
  }

  Future<int> add(Insertable<UserDataClass> value) async {
    final res = await accessor.into(table).insert(value);
    dev.log('In add for ${UserDataClass.runtimeType}: $value, added id: $res');
    return res;
  }

  Future<void> addAll(IList<Insertable<UserDataClass>> values) async {
    dev.log('In addAll for ${UserDataClass.runtimeType}: $values');
    await accessor.batch((batch) {
      batch.insertAll(
        table,
        values,
      );
    });
  }

  Future<IList<UserDataClass>> getAll() async {
    var result = (await accessor.select(table).get()).toIList();
    dev.log('In get for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  ValueStream<IList<UserDataClass>> streamWhere(
      Expression<bool> Function(UserTable tbl) filter,
      ) {
    return ValueConnectableStream((accessor.select(table)
      ..where(
        filter,
      ))
        .watch()
        .map(
          (list) => list.toIList(),
    ));
  }

  Future<UserDataClass?> firstWhere(
      Expression<bool> Function(UserTable tbl) filter,
      ) async {
    var result = await (accessor.select(table)
      ..where(
        filter,
      ))
        .getSingleOrNull();
    dev.log('In firstWhere for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  Future<IList<UserDataClass>> where(
      Expression<bool> Function(UserTable tbl) filter,
      ) async {
    var result = (await (accessor.select(table)
      ..where(
        filter,
      ))
        .get())
        .toIList();
    dev.log('In where for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  Future<void> updateWhere(
      Insertable<UserDataClass> value,
      Expression<bool> Function(UserTable tbl) filter,
      ) async {
    var result = await (accessor.update(table)
      ..where(
        filter,
      ))
        .write(value);
    dev.log('In updateWhere for ${UserDataClass.runtimeType}: $result');
  }

  Future<void> deleteWhere(
      Expression<bool> Function(UserTable tbl) filter,
      ) async {
    var result = await (accessor.delete(table)
      ..where(
        filter,
      ))
        .go();
    dev.log('In deleteWhere for ${UserDataClass.runtimeType}: $result');
  }
}