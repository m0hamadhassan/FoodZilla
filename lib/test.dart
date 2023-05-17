import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzilla/database/database.dart';
import 'package:foodzilla/pages/mainmenu/models/food2.dart';

class GG extends StatelessWidget {
  const GG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sqlDb db = sqlDb();

    return FutureBuilder<List<int>>(
      future: db.getTableIds("id", "meals"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<int> foodIds = snapshot.data!;
          return ListView.builder(
            itemCount: foodIds.length,
            itemBuilder: (context, index) {
              int id = foodIds[index];
              return FutureBuilder<Food2>(
                future: db.getFoodDetails("mealImage", "meals", "id", id),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    Food2 food = snapshot.data!;
                    Uint8List? imageBytes = food.imageBytes;
                    String name = food.name;
                    String price = food.price;

                    return Card(
                      child: ListTile(
                        leading: Image.memory(
                          imageBytes!,
                          width: 48,
                          height: 48,
                        ),
                        title: Text(name),
                        subtitle: Text(price),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Handle card tap
                        },
                      ),
                    );
                  } else {
                    return Card(
                      child: ListTile(
                        title: Text('No image found'),
                      ),
                    );
                  }
                },
              );
            },
          );
        } else {
          return Text('No data found');
        }
      },
    );
  }
}
