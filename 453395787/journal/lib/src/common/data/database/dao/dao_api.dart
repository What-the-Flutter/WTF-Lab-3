import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';

mixin BaseDaoApi<UserDataClass extends DataClass, UserTable extends Table> {
  TableInfo<UserTable, UserDataClass> get table => throw UnimplementedError();

  DatabaseAccessor get accessor => throw UnimplementedError();

  static final Logger log = Logger(
    printer: PrettyPrinter(
      methodCount: 7,
    ),
  );

  Future<int> add(Insertable<UserDataClass> value) async {
    log.d('In add for ${UserDataClass.runtimeType}: $value');
    return accessor.into(table).insert(value);
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

  Future<UserDataClass?> firstWhere(
      Expression<bool> Function(UserTable tbl) filter) async {
    var result = await (accessor.select(table)
          ..where(
            (tbl) => filter(tbl),
          ))
        .getSingleOrNull();
    log.d('In firstWhere for ${UserDataClass.runtimeType}: $result');
    return result;
  }

  Future<IList<UserDataClass>> where(
      Expression<bool> Function(UserTable tbl) filter) async {
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
    Expression<bool> Function(UserTable tbl) filter,
  ) async {
    var result = await (accessor.update(table)
          ..where(
            (tbl) => filter(tbl),
          ))
        .write(value);
    log.d('In updateWhere for ${UserDataClass.runtimeType}: $result');
  }

  Future<void> deleteWhere(
    Expression<bool> Function(UserTable tbl) filter,
  ) async {
    var result = await (accessor.delete(table)
          ..where(
            (tbl) => filter(tbl),
          ))
        .go();
    log.d('In deleteWhere for ${UserDataClass.runtimeType}: $result');
  }
}
