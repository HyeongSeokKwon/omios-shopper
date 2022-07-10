import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  late Database _db;

  Future<Database> get db async {
    _db = await initDB();
    return _db;
  }

  void closeDB() {
    _db.close();
  }
}

Future<Database> initDB() async {
  var dbPath = await getDatabasesPath();
  String path = join(dbPath,
      'deepy_database.db'); //database  경로 지정! join 함수를 통해 각 플랫폼 별로 경로 생성 보장가능)
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS RECENTVIEW(productId INTEGER PRIMARY KEY NOT NULL,time DATETIME)',
      );
      await db.execute(
        'CREATE TABLE IF NOT EXISTS RECENTSEARCHES(searches STRING PRIMARY KEY NOT NULL)',
      );
    },
  );
}

Future<List<dynamic>> getRecentView(Future<Database> db) async {
  Database database = await db;
  final List<Map<String, dynamic>> maps = await database.rawQuery(
    'SELECT * FROM RECENTVIEW ORDER BY time DESC',
  );
  return maps;
}

Future<void> setRecentView(Future<Database> db, int productId) async {
  Database database = await db;
  await database.rawQuery(
    'INSERT INTO RECENTVIEW VALUES($productId,CURRENT_TIMESTAMP)',
  );
  final List<Map<String, dynamic>> maps = await database.rawQuery(
    'SELECT * FROM RECENTVIEW ORDER BY time DESC',
  );
}

void deleteRecent(Future<Database> db, int productId) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW WHERE productId=$productId',
  );
}

void deleteOldestRecent(Future<Database> db) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW WHERE productId=(SELECT productId FROM RECENTVIEW LIMIT 1,1)',
  );
}

Future<void> setRecentSearches(Future<Database> db, String searches) async {
  Database database = await db;
  final List<Map<String, dynamic>> maps =
      await database.rawQuery('INSERT INTO RECENTSEARCHES VALUES($searches)');
}

Future<List<dynamic>> getRecentSearches(Future<Database> db) async {
  Database database = await db;
  final List<Map<String, dynamic>> maps = await database.rawQuery(
    'SELECT * FROM RECENTSEARCHES',
  );
  return maps;
}

void deleteRecentSearches(Future<Database> db, String searches) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW WHERE searches=$searches',
  );
}

void deleteAllRecentSearches(Future<Database> db) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW',
  );
}
