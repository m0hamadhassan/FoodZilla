import 'package:flutter/material.dart';
import 'package:foodzilla/pages/restaurantsPage/widgets/restaurant_list.dart';

import '../../database/database.dart';
import '../mainmenu/models/restaurant.dart';

class RestaurantsPage extends StatelessWidget {
  SqlDb db = new SqlDb();

  // Fetch restaurant IDs from the database
  Future<List<int>> getRestsId() async {
    List<int> restIds = await db.getTableIds('restId', 'restaurant');
    return restIds;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Restaurant>> restListFuture =
        getRestsId().then((restIds) => db.getRestaurantDetailsList(restIds));

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
              "Restaurants List")), // Corrected the word "Restaurents" to "Restaurants"
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RestaurantList(restListFuture),
        ),
      ),
    );
  }
}
