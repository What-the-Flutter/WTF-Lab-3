import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

typedef Filter<T> = Expression<bool> Function(T tbl);

mixin BaseDao<UserDataClass extends DataClass, UserTable extends Table> {
  static final Logger log = Logger();

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

  void close() {
    _subscription.cancel();
  }

  Future<int> add(Insertable<UserDataClass> value) async {
    final res = await accessor.into(table).insert(value);
    log.d('In add for ${UserDataClass.runtimeType}: $value, added id: $res');
    return res;
  }

  Future<void> addAll(IList<Insertable<UserDataClass>> values) async {
    log.d('In addAll for ${UserDataClass.runtimeType}: $values');
    await accessor.batch((batch) {
      batch.insertAll(
        table,
        values,
      );
    });
  }

  Future<IList<UserDataClass>> getAll() async {
    var result = (await accessor.select(table).get()).toIList();
    log.d('In get for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  ValueStream<IList<UserDataClass>> streamWhere(
    Filter<UserTable> filter,
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
    Filter<UserTable> filter,
  ) async {
    var result = await (accessor.select(table)
          ..where(
            filter,
          ))
        .getSingleOrNull();
    log.d('In firstWhere for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  Future<IList<UserDataClass>> where(
    Filter<UserTable> filter,
  ) async {
    var result = (await (accessor.select(table)
              ..where(
                filter,
              ))
            .get())
        .toIList();
    log.d('In where for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  Future<void> updateWhere(
    Insertable<UserDataClass> value,
    Filter<UserTable> filter,
  ) async {
    var result = await (accessor.update(table)
          ..where(
            filter,
          ))
        .write(value);
    log.d('In updateWhere for ${UserDataClass.runtimeType}: $result');
  }

  Future<void> deleteWhere(
    Filter<UserTable> filter,
  ) async {
    var result = await (accessor.delete(table)
          ..where(
            filter,
          ))
        .go();
    log.d('In deleteWhere for ${UserDataClass.runtimeType}: $result');
  }
}
