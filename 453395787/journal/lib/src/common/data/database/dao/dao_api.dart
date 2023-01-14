import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

typedef Filter<T> = Expression<bool> Function(T tbl);

mixin BaseDaoApi<UserDataClass extends DataClass, UserTable extends Table> {
  TableInfo<UserTable, UserDataClass> get table => throw UnimplementedError();

  DatabaseAccessor get accessor => throw UnimplementedError();

  static final Logger log = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
    ),
  );

  final BehaviorSubject<IList<UserDataClass>> _stream = BehaviorSubject.seeded(
    IList<UserDataClass>([]),
  );

  void init() {
    accessor.select(table).watch().listen((event) {
      _stream.add(event.toIList());
    });
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

  Future<IList<UserDataClass>> get() async {
    var result = (await accessor.select(table).get()).toIList();
    log.d('In get for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  ValueStream<IList<UserDataClass>> get stream => _stream.stream;

  ValueStream<IList<UserDataClass>> streamWhere(
    Filter<UserTable> filter,
  ) {
    return ValueConnectableStream((accessor.select(table)
          ..where(
            (tbl) => filter(tbl),
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
            (tbl) => filter(tbl),
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
                (tbl) => filter(tbl),
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
            (tbl) => filter(tbl),
          ))
        .write(value);
    log.d('In updateWhere for ${UserDataClass.runtimeType}: $result');
  }

  Future<void> deleteWhere(
    Filter<UserTable> filter,
  ) async {
    var result = await (accessor.delete(table)
          ..where(
            (tbl) => filter(tbl),
          ))
        .go();
    log.d('In deleteWhere for ${UserDataClass.runtimeType}: $result');
  }
}
