import 'package:flutter/material.dart';

import '../models/food.dart';
import 'food_item.dart';

class FoodList extends StatelessWidget {
  var totalPrice = 0;

  final List<Food> foodList;
  FoodList(this.foodList);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView.builder(
          itemCount: recommendedFoods.length,
          itemBuilder: (ctx, index) {
            return FoodItem(recommendedFoods[index]);
          },
        ));
  }
}
