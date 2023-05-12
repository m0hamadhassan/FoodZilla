import 'package:flutter/material.dart';

import '../constants/colors/colors.dart';
import '../models/food.dart';

class FoodItem extends StatelessWidget {
  final Food foodItem;
  static num totalPrice = 0;

  static List<Food> checkoutList = [];
  FoodItem(this.foodItem);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => {
            totalPrice += foodItem.price,
            print(totalPrice),
            checkoutList.add(foodItem),
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 110,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    foodItem.imageUrl,
                    fit: BoxFit.cover,
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(foodItem.name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                )),
                            Icon(
                              Icons.add_circle_outlined,
                              size: 30,
                            ),
                          ],
                        ),
                        Text(
                          foodItem.desc,
                          style: TextStyle(
                            color: foodItem.highlight
                                ? kPrimaryColor
                                : Colors.grey.withOpacity(0.8),
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text('\$',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(foodItem.price.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ]),
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
