import 'package:flutter/material.dart';
import 'package:foodzilla/pages/mainmenu/models/restaurant.dart';

import '../../mainmenu/constants/colors/colors.dart';
import '../../mainmenu/models/food.dart';

class RestaurantITem extends StatelessWidget {
  final Restaurant restItem;

  static List<Food> checkoutList = [];
  RestaurantITem(this.restItem);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              child: InkWell(
                onTap: () => {},
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
                        child: restItem.imageBytes != null
                            ? Image.memory(
                                restItem.imageBytes!,
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
                        child: Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(restItem.restName,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                          )),
                                    ),
                                    Icon(
                                      Icons.add_circle_outlined,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Text(
                                  restItem.restName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 6),
                              ]),
                        ),
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
      ),
    );
  }
}
