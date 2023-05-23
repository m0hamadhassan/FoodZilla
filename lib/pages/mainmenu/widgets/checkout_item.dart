import 'package:flutter/material.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_item.dart';

import '../constants/colors/colors.dart';
import '../models/food.dart';

class CheckoutItem extends StatelessWidget {
  final Food checkoutItem;
  CheckoutItem(this.checkoutItem);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120,
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
                child: checkoutItem.imageBytes != null
                    ? Image.memory(
                        checkoutItem.imageBytes!,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(checkoutItem.name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                )),
                          ),
                        ],
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
                          Text(checkoutItem.price.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            'Quantity: ${checkoutItem.quantity.toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ]),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
