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
	FOREIGN KEY("userId") REFERENCES "users"("id"),
	FOREIGN KEY("mealId") REFERENCES "meals"("id")
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
CREATE TABLE IF NOT EXISTS "foods" (
	"id"	INTEGER,
	"image"	BLOB,
	PRIMARY KEY("id")
);

