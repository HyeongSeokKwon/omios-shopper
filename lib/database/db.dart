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
      print("onCreate");
      await db.execute(
        'CREATE TABLE IF NOT EXISTS RECENTVIEW(productCode VARCHAR(15) PRIMARY KEY NOT NULL,time DATETIME)',
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

Future<void> setRecentView(Future<Database> db, String productCode) async {
  Database database = await db;
  await database.rawQuery(
    'INSERT INTO RECENTVIEW VALUES("$productCode",CURRENT_TIMESTAMP)',
  );
  final List<Map<String, dynamic>> maps = await database.rawQuery(
    'SELECT * FROM RECENTVIEW ORDER BY time DESC',
  );
  print(maps.toString());
}

void deleteRecent(Future<Database> db, String productCode) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW WHERE productCode="$productCode"',
  );
}

void deleteOldestRecent(Future<Database> db) async {
  Database database = await db;
  await database.rawQuery(
    'DELETE FROM RECENTVIEW WHERE productCode=(SELECT productCode FROM RECENTVIEW LIMIT 1,1)',
  );
}
