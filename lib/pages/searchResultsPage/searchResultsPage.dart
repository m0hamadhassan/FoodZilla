import 'package:flutter/material.dart';
import 'package:foodzilla/database/database.dart';
import '../mainmenu/models/food.dart';
import '../mainmenu/models/restaurant.dart';
import '../mainmenu/widgets/food_list.dart';
import '../restaurantsPage/widgets/restaurant_list.dart';

class SearchResultsPage extends StatelessWidget {
  String searchQuery;
  SearchResultsPage(this.searchQuery);
  SqlDb db = new SqlDb();

  @override
  Widget build(BuildContext context) {
    Future<List<Food>> mealsList = db.searchMealsByName(searchQuery);
    Future<List<Restaurant>> restList = db.searchRestaurantsByName(searchQuery);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Search Results"),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Meals'),
              Tab(text: 'Restaurants'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Food>>(
              future: mealsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FoodList(mealsList);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            FutureBuilder<List<Restaurant>>(
              future: restList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RestaurantList(restList);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
