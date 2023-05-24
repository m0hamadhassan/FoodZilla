import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';

import '../pages/mainmenu/models/food.dart';
import '../pages/mainmenu/models/restaurant.dart';
import 'dart:io';

class SqlDb {
  static Database? _db;

  //if _db exists

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  initializeDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'foodzilla.db');
    bool dbExists = await databaseExists(path);

    if (!dbExists) {
      ByteData data = await rootBundle.load('assets/foodzilla.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return openDatabase(path);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    /*await db.execute('''
     CREATE TABLE restaurant (
        restId INTEGER PRIMARY KEY ,
        restImage  Uint8List,
        restName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY ,
        mealImage  Uint8List,
        mealName TEXT,
        mealPrice REAL,
        restaurant_id INTEGER,
        recommended INTEGER DEFAULT 0,

        FOREIGN KEY (restaurant_id) REFERENCES restaurant (restaurant_id)
      )
      ''');*/
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

    await db.execute('''
    CREATE TABLE IF NOT EXISTS "cart" (
        "Id"	INTEGER,
        "mealId"	INTEGER,
        "userId"	INTEGER,
        "quantity"	INTEGER,
        FOREIGN KEY("userId") REFERENCES "users"("id"),
    FOREIGN KEY("mealId") REFERENCES "meals"("id"),
    PRIMARY KEY("Id")
    )
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

  Future<void> showDatabaseTables() async {
    Database? mydb = await db;

    final tables = await mydb
        ?.query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    final tableNames = tables?.map((table) => table['name'] as String).toList();

    for (final tableName in tableNames!) {
      final columns = await mydb?.rawQuery('PRAGMA table_info($tableName)');
      final columnNames =
          columns?.map((column) => column['name'] as String).toList();
      print('Table: $tableName');
      print('Columns: $columnNames');
      // print(records);
    }
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

  getDatabasePath() async {
    String dbPath = await getDatabasesPath();

    // create name of database
    String path = join(dbPath, 'foodzilla.db'); // db path add to it wael.db

    print(path);
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

  Future<List<int>> getRecommendedMeal() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'foodzilla.db');
    Database database = await openDatabase(dbPath);

    List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT id FROM meals where recommended = 1 ');

    List<int> ids = [];
    for (var row in result) {
      int id = row['id'];
      ids.add(id);
    }

    return ids;
  }

  Future<List<int>> getAllMeals() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'foodzilla.db');
    Database database = await openDatabase(dbPath);

    List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT id FROM meals ');

    List<int> ids = [];
    for (var row in result) {
      int id = row['id'];
      ids.add(id);
    }

    return ids;
  }

  Future<List<Food>> getFoodDetailsList(List<int> foodIds) async {
    List<Food> foodList = [];
    Database? mydb = await db;
    String name = "", restName = "", price = "";
    Uint8List? imageBytes = null;

    for (int foodId in foodIds) {
      // Fetch name and price from the database or API
      List<Map<String, dynamic>> result = await mydb!
          .rawQuery('SELECT mealName FROM meals WHERE id = ?', [foodId]);
      if (result.isNotEmpty) name = result.first['mealName'].toString();

      //restName
      List<Map<String, dynamic>> result2 = await mydb.rawQuery('''
      SELECT restName 
      FROM meals JOIN restaurant
      ON restaurant_id=restId
      WHERE id = ?
      ''', [foodId]);
      if (result2.isNotEmpty) restName = result2.first['restName'].toString();

      //price
      List<Map<String, dynamic>> result3 = await mydb
          .rawQuery('SELECT mealPrice FROM meals WHERE id = ?', [foodId]);
      if (result3.isNotEmpty) price = result3.first['mealPrice'].toString();

      // Fetch image bytes from the database or API

      List<Map<String, dynamic>> result4 =
          await mydb.rawQuery('SELECT mealImage FROM meals WHERE id = $foodId');

      if (result4.isNotEmpty) imageBytes = result4.first['mealImage'];

      // Create a Food object with the retrieved data

      Food food = Food(
        imageBytes,
        // Assuming the image file names follow a specific pattern
        name,
        restName,
        '',
        0.0,
        // You can set the rating, sales, and other properties accordingly
        double.parse(price),
        0,
      );

      foodList.add(food);
    }

    return foodList;
  }

  Future<List<Restaurant>> getRestaurantDetailsList(List<int> restIds) async {
    List<Restaurant> restList = [];
    Database? mydb = await db;
    String name = "";
    Uint8List? imageBytes = null;

    for (int restId in restIds) {
      List<Map<String, dynamic>> result = await mydb!.rawQuery(
          'SELECT restName FROM restaurant WHERE restId = ?', [restId]);
      if (result.isNotEmpty) name = result.first['restName'].toString();

      List<Map<String, dynamic>> result4 = await mydb
          .rawQuery('SELECT restImage FROM restaurant WHERE restId = $restId');
      if (result4.isNotEmpty) imageBytes = result4.first['restImage'];

      Restaurant restaurant = Restaurant(restId, imageBytes, name);
      restList.add(restaurant);
    }

    return restList;
  }

  Future<String> getAddressByUsername(String username) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!.rawQuery(
      'SELECT address FROM "users" WHERE username = ?',
      [username],
    );

    if (result.isNotEmpty) {
      return result.first['address'];
    } else {
      return "";
    }
  }

  Future<String> getMobileByUsername(String username) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!.rawQuery(
      'SELECT phone_number FROM "users" WHERE username = ?',
      [username],
    );

    if (result.isNotEmpty) {
      return result.first['phone_number'];
    } else {
      return "";
    }
  }

  Future<List<Food>> getFoodDetailsListByRestaurantId(int restaurantId) async {
    List<Food> foodList = [];
    Database? mydb = await db;

    // Fetch food details based on the restaurant ID
    List<Map<String, dynamic>> result = await mydb!.rawQuery('''
    SELECT m.id, m.mealImage, m.mealName, m.mealPrice, r.restName
    FROM meals AS m
    INNER JOIN restaurant AS r ON m.restaurant_id = r.restId
    WHERE m.restaurant_id = ?
  ''', [restaurantId]);

    for (var row in result) {
      int id = row['id'];
      Uint8List? imageBytes = row['mealImage'];
      String name = row['mealName'];
      double price = row['mealPrice'];
      String restName = row['restName'];

      Food food = Food(
        imageBytes,
        name,
        restName,
        '',
        0,
        price,
        0,
      );

      foodList.add(food);
    }

    return foodList;
  }

  Future<List<Food>> searchMealsByName(String mealName) async {
    List<Food> foodList = [];
    Database? mydb = await db;

    // Fetch food details based on the meal name
    List<Map<String, dynamic>> result = await mydb!.rawQuery('''
    SELECT m.id, m.mealImage, m.mealName, m.mealPrice, r.restName
    FROM meals AS m
    INNER JOIN restaurant AS r ON m.restaurant_id = r.restId
    WHERE m.mealName LIKE '%' || ? || '%'
  ''', [mealName]);

    for (var row in result) {
      int id = row['id'];
      Uint8List? imageBytes = row['mealImage'];
      String name = row['mealName'];
      double price = row['mealPrice'];
      String restName = row['restName'];

      Food food = Food(
        imageBytes,
        name,
        restName,
        '',
        0,
        price,
        0,
      );

      foodList.add(food);
    }

    return foodList;
  }

  Future<List<Restaurant>> searchRestaurantsByName(String name) async {
    Database? mydb = await db;

    List<Map<String, dynamic>> result = await mydb!.rawQuery(
      'SELECT * FROM restaurant WHERE restName LIKE ?',
      ['%$name%'],
    );

    List<Restaurant> restaurants = [];
    for (var row in result) {
      int restId = row['restId'];
      Uint8List? restImage = row['restImage'];
      String restName = row['restName'];

      Restaurant restaurant = Restaurant(restId, restImage, restName);
      restaurants.add(restaurant);
    }

    return restaurants;
  }
}
