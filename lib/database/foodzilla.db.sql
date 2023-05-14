BEGIN TRANSACTION;
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
INSERT INTO "users" VALUES (1,'John Doe','john.doe@example.com','password123','123 Main St','1234567890');
INSERT INTO "users" VALUES (2,'Jane Smith','jane.smith@example.com','pass456','456 Elm St','9876543210');
INSERT INTO "users" VALUES (3,'Mike Johnson','mike.johnson@example.com','pass789','789 Oak St','5678901234');
INSERT INTO "users" VALUES (4,'Sarah Williams','sarah.williams@example.com','pass1234','456 Pine St','1234509876');
INSERT INTO "users" VALUES (5,'David Brown','david.brown@example.com','pass5678','789 Maple St','9876512340');
INSERT INTO "cart" VALUES (1,2,1,2);
INSERT INTO "cart" VALUES (2,2,1,1);
INSERT INTO "cart" VALUES (3,1,2,3);
INSERT INTO "cart" VALUES (4,4,3,2);
INSERT INTO "cart" VALUES (5,5,4,1);
INSERT INTO "meals" VALUES (1,'meal1.jpg','Meal 1',10.99,'Cheeseburger');
INSERT INTO "meals" VALUES (2,'meal2.jpg','Meal 2',9.99,'Chicken Sandwich');
INSERT INTO "meals" VALUES (3,'meal3.jpg','Meal 3',12.99,'Pasta Alfredo');
INSERT INTO "meals" VALUES (4,'meal4.jpg','Meal 4',8.99,'Margherita Pizza');
INSERT INTO "meals" VALUES (5,'meal5.jpg','Meal 5',11.99,'Grilled Salmon');
COMMIT;
