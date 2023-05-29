import 'package:flutter/material.dart';

import '../constants/colors/colors.dart';
import '../models/food.dart';

class FoodItem extends StatelessWidget {
  final Food foodItem;
  static num totalPrice = 0;
  static List<Food> checkoutList = [];

  final snackBar = SnackBar(
    duration: Duration(milliseconds: 800),
    content: const Text(
      'New Meal added to cart',
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
    backgroundColor: Colors.purple,
  );

  FoodItem(this.foodItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    totalPrice += foodItem.price;
                    if (foodItem.quantity == 0) {
                      checkoutList.add(foodItem);
                    }
                    checkoutList[checkoutList.indexOf(foodItem)].quantity += 1;
                    print(
                        checkoutList[checkoutList.indexOf(foodItem)].quantity);
                  },
                  child: Ink(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Ink(
                          padding: EdgeInsets.all(5),
                          width: 120,
                          height: 110,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: foodItem.imageBytes != null
                                ? Image.memory(
                                    foodItem.imageBytes!,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        foodItem.name,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_outlined,
                                      size: 35,
                                    ),
                                  ],
                                ),
                                Text(
                                  foodItem.restName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      'EGP',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      foodItem.price.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
