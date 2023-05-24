import 'package:flutter/material.dart';
import 'package:foodzilla/pages/restaurantsPage/widgets/restaurant_list.dart';

import '../../database/database.dart';
import '../mainmenu/models/restaurant.dart';

class RestaurantsPage extends StatelessWidget {
  SqlDb db = new SqlDb();

  // Fetch restaurant IDs from the database
  Future<List<int>> getRestsId() async {
    // Retrieve the restaurant IDs from the 'restaurant' table in the database
    List<int> restIds = await db.getTableIds('restId', 'restaurant');
    return restIds;
  }

  @override
  Widget build(BuildContext context) {
    // Get a future list of Restaurant objects based on restaurant IDs
    Future<List<Restaurant>> restListFuture =
        getRestsId().then((restIds) => db.getRestaurantDetailsList(restIds));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Restaurants List"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // Display the list of restaurants using the RestaurantList widget
          child: RestaurantList(restListFuture),
        ),
      ),
    );
  }
}
