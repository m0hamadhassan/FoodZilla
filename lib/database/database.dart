import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlDb {
  static Database? _db;

  //if _db exists

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  intializeDb() async {
    String dbPath = await getDatabasesPath();

    // create name of database
    String path = join(dbPath, 'foodzilla.db'); // db path add to it wael.db
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);

    final exist = await databaseExists(path);

    if (exist) {
      //db already exist
      // open db
      //print("db already exists");
      await openDatabase(path);
      print(path);
    } else {
      //db doesnt exit create
      print("create ");
      print(path);
    }

    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "users" (
	  "id"	INTEGER,
	  "username"	TEXT,
	  "email"	TEXT,
	  "password"	TEXT,
	  "address"	TEXT,
	  "phone_number"	TEXT,
	  PRIMARY KEY("id" AUTOINCREMENT)
    );
    CREATE TABLE IF NOT EXISTS "cart" (
    "Id"	INTEGER,
    "mealId"	INTEGER,
    "userId"	INTEGER,
    "quantity"	INTEGER,
    PRIMARY KEY("Id"),
    FOREIGN KEY("userId") REFERENCES "users"("id"),
    FOREIGN KEY("mealId") REFERENCES "meals"("id")
  );
    ''');
  }

  // called only once at creation of db
  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "users" (
	  "id"	INTEGER,
	  "username"	TEXT,
	  "email"	TEXT,
	  "password"	TEXT,
	  "address"	TEXT,
	  "phone_number"	TEXT,
	  PRIMARY KEY("id" AUTOINCREMENT)
    );
    CREATE TABLE IF NOT EXISTS "cart" (
    "Id"	INTEGER,
    "mealId"	INTEGER,
    "userId"	INTEGER,
    "quantity"	INTEGER,
    PRIMARY KEY("Id"),
    FOREIGN KEY("userId") REFERENCES "users"("id"),
    FOREIGN KEY("mealId") REFERENCES "meals"("id")
  );
  CREATE TABLE IF NOT EXISTS "meals" (
    "id"	INTEGER,
    "image"	TEXT,
    "text"	TEXT,
    "price"	REAL,
    "name"	TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
  );

  ''');
    print("Oncreate#######################");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  dropTable(String s) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate('DROP TABLE IF EXISTS "$s"');
    return response;
  }

  Future<bool> isEmailAlreadyExists(String email) async {
    Database? mydb = await db; // Open your database connection
    List<Map<String, dynamic>> result = await mydb!.rawQuery('''
    SELECT COUNT(*) as count FROM "users" WHERE email = ?;
  ''', [email]);
    int? count = Sqflite.firstIntValue(result);
    return count! > 0;
  }

  Future<bool> isUsernameExists(String username) async {
    Database? mydb = await db; // Open your database connection
    List<Map<String, dynamic>> result = await mydb!.rawQuery('''
    SELECT COUNT(*) as count FROM "users" WHERE username = ?;
  ''', [username]);
    int? count = Sqflite.firstIntValue(result);
    return count! > 0;
  }

  checkPassword(String username) async {
    if (await isUsernameExists(username)) {
      Database? mydb = await db;
      List<Map<String, dynamic>> response = await mydb!.rawQuery('''
     SELECT password FROM "users" Where username= ?;
     ''', [username]);

      return response[0]['password'];
    } else {
      return ("&"); //this means password doesnt exist
    }
  }
}
