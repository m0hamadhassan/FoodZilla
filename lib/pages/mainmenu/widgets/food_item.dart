import 'package:flutter/material.dart';

import '../constants/colors/colors.dart';
import '../models/food.dart';

class FoodItem extends StatelessWidget {
  final Food foodItem;
  static num totalPrice = 0;
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 500),
    content: const Text(
      'New Meal added to cart',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: (Colors.purple),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );

  static List<Food> checkoutList = [];
  FoodItem(this.foodItem);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            child: InkWell(
              onTap: () => {
                ScaffoldMessenger.of(context).showSnackBar(snackBar),
                totalPrice += foodItem.price,
                if (foodItem.quantity == 0)
                  {
                    checkoutList.add(foodItem),
                  },
                checkoutList[checkoutList.indexOf(foodItem)].quantity += 1,
                print(checkoutList[checkoutList.indexOf(foodItem)].quantity),
              },
              child: Ink(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(children: [
                  Ink(
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
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
