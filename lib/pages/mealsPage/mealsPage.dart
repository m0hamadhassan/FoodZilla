import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_list.dart';
import 'package:foodzilla/pages/restaurantsPage/widgets/restaurant_list.dart';
import '../../database/database.dart';
import '../mainmenu/models/food.dart';
import '../mainmenu/models/restaurant.dart';

class MealsPage extends StatelessWidget {
  String id;
  MealsPage(this.id);
  SqlDb db = new SqlDb();
  //for all meals in meals page

  Future<List<int>> getRecommid() async {
    List<int> foodIds =
        await db.getRecommendedMeal(); // Example list of food IDs
    return foodIds;
  }

  Future<List<int>> getAllid() async {
    List<int> foodIds = await db.getAllMeals(); // Example list of food IDs
    return foodIds;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Food>> foodListfuture =
        getAllid().then((foodIds) => db.getFoodDetailsList(foodIds));
    if (id == 'all') {
      foodListfuture =
          getAllid().then((foodIds) => db.getFoodDetailsList(foodIds));
    } else {
      foodListfuture = db.getFoodDetailsListByRestaurantId(int.parse(id));
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Available Meals")),
      body: FoodList(foodListfuture),
    );
  }
}
