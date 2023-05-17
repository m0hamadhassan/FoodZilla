import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../pages/mainmenu/models/food2.dart';

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
    CREATE TABLE IF NOT EXISTS "android_metadata" (
	"locale"	TEXT
);
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
	FOREIGN KEY("mealId") REFERENCES "meals"("id"),
	FOREIGN KEY("userId") REFERENCES "users"("id")
);
CREATE TABLE IF NOT EXISTS "meals" (
	"id"	INTEGER,
	"mealImage"	BLOB,
	"mealName"	TEXT,
	"mealPrice"	REAL,
	"restaurant_id"	INTEGER,
	"recommended"	INTEGER DEFAULT 0,
	PRIMARY KEY("id"),
	FOREIGN KEY("restaurant_id") REFERENCES "restaurant"("restaurant_id")
);
CREATE TABLE IF NOT EXISTS "restaurant" (
	"restId"	INTEGER,
	"restImage"	BLOB,
	"restName"	TEXT,
	PRIMARY KEY("restId")
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

  Future<Uint8List?> getImageBytesFromDatabase(
      String imgColumn, String tableName) async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'foodzilla.db');
    Database database = await openDatabase(dbPath);

    List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT $imgColumn FROM $tableName');

    if (result.isNotEmpty) {
      Uint8List? imageBytes = result.first['$imgColumn'];
      return imageBytes;
    }

    return null;
  }

  // to get ids to show images
  Future<List<int>> getTableIds(String idCol, String tableName) async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'foodzilla.db');
    Database database = await openDatabase(dbPath);

    List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT $idCol FROM $tableName');

    List<int> Ids = [];
    for (var row in result) {
      int Id = row['$idCol'];
      Ids.add(Id);
    }

    return Ids;
  }

  // to show all images
  Future<Uint8List?> getImages(
      int id, String imgColumn, String tableName, String idCol) async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'foodzilla.db');
    Database database = await openDatabase(dbPath);

    List<Map<String, dynamic>> result = await database
        .rawQuery('SELECT $imgColumn FROM $tableName WHERE $idCol = $id');

    if (result.isNotEmpty) {
      Uint8List? imageBytes = result.first['$imgColumn'];
      return imageBytes;
    }

    return null;
  }

  Future<String> getNameFromDatabase(int foodId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!
        .rawQuery('SELECT mealName FROM meals WHERE id = ?', [foodId]);
    if (result.isNotEmpty) {
      return result.first['mealName'].toString();
    }
    return '';
  }

  Future<String> getPriceFromDatabase(int foodId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!
        .rawQuery('SELECT mealPrice FROM meals WHERE id = ?', [foodId]);
    if (result.isNotEmpty) {
      return result.first['mealPrice'].toString();
    }
    return '';
  }

  Future<Food2> getFoodDetails(
    String imgColumn,
    String tableName,
    String idCol,
    int foodId,
  ) async {
    // Perform database query or API call to fetch food details
    // Here's an example of how you can retrieve the necessary information

    // Fetch image bytes from the database or API
    Uint8List? imageBytes =
        await getImages(foodId, imgColumn, tableName, idCol);

    // Fetch name and price from the database or API
    String name = await getNameFromDatabase(foodId);
    String price = await getPriceFromDatabase(foodId);

    // Create a Food object with the retrieved data
    Food2 food = Food2(
      imageBytes: imageBytes,
      name: name,
      price: price,
    );

    return food;
  }
}
