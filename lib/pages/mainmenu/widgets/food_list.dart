import 'package:flutter/material.dart';
import '../models/food.dart';
import 'food_item.dart';

class FoodList extends StatelessWidget {
  var totalPrice = 0;

  final Future<List<Food>> foodListFuture;

  FoodList(this.foodListFuture);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: foodListFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting for the future to complete
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if the future encountered an error
        } else {
          final List<Food> foodList =
              snapshot.data!; // Access the retrieved food list
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (ctx, index) {
                return FoodItem(foodList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
