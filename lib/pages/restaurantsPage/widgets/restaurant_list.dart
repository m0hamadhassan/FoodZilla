// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodzilla/pages/mainmenu/models/restaurant.dart';
import 'package:foodzilla/pages/restaurantsPage/widgets/restaurant_item.dart';

class RestaurantList extends StatelessWidget {
  var totalPrice = 0;

  final Future<List<Restaurant>> restListFuture;

  RestaurantList(this.restListFuture);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: restListFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting for the future to complete
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if the future encountered an error
        } else {
          final List<Restaurant> restList =
              snapshot.data!; // Access the retrieved food list
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: restList.length,
              itemBuilder: (ctx, index) {
                return RestaurantITem(restList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
