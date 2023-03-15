import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final eventTable = 'Event';
final chatTable = 'Chat';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, 'chat_journal.db');

    var database = await openDatabase(path, version: 1, onCreate: initDatabase);
    return database;
  }

  void initDatabase(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $eventTable (
        id TEXT PRIMARY KEY NOT NULL,
        chat_id TEXT NOT NULL,
        title TEXT NOT NULL,
        time TEXT NOT NULL,
        category_index INTEGER NOT NULL,
        is_favourite INTEGER NOT NULL,
        is_selected INTEGER NOT NULL,
        is_selection_mode INTEGER NOT NULL
      )
    ''');

    await database.execute('''
      CREATE TABLE $chatTable (
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        icon_id INTEGER NOT NULL,
        is_pinned INTEGER NOT NULL,
        is_showing_favourites INTEGER NOT NULL
      )
    ''');
  }
}
