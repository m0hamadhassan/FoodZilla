import 'package:flutter/material.dart';

import '../models/food.dart';
import 'checkout_item.dart';
import 'food_item.dart';

class CheckoutList extends StatelessWidget {
  var totalPrice = 0;

  List<Food> checkoutList;
  CheckoutList(this.checkoutList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 350,
          child: ListView.builder(
            itemCount: checkoutList.length,
            itemBuilder: (ctx, index) {
              if (checkoutList.length >= index) {
                return CheckoutItem(checkoutList[index]);
              } else {
                return Card(
                  child: Text('End of list'),
                );
              }
            },
          )),
    );
  }
}
