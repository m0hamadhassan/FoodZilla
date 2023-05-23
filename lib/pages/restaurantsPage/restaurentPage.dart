import 'package:flutter/material.dart';
import 'package:foodzilla/pages/restaurantsPage/widgets/restaurant_list.dart';

import '../../database/database.dart';
import '../mainmenu/models/restaurant.dart';

class RestaurantsPage extends StatelessWidget {
  SqlDb db = new SqlDb();
  //for all meals in meals page
  Future<List<int>> getRestsId() async {
    List<int> restIds = await db.getTableIds(
        'restId', 'restaurant'); // Example list of food IDs
    return restIds;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Restaurant>> restListFuture =
        getRestsId().then((restIds) => db.getRestaurantDetailsList(restIds));
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Restaurents List")),
      body: RestaurantList(restListFuture),
    );
  }
}
