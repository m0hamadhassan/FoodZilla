import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzilla/database/database.dart';
import 'package:foodzilla/pages/mainmenu/widgets/checkout_list.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_item.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../checkout/checkoutPage.dart';
import '../mealsPage/mealsPage.dart';
import '../restaurantsPage/restaurentPage.dart';
import '../searchResultsPage/searchResultsPage.dart';
import 'models/food.dart';
import 'widgets/home_page_title.dart';

class LandingPage extends StatefulWidget {
  final String userName;
  LandingPage(this.userName);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController _searchController = TextEditingController();
  //var selected = 0;
  SqlDb db = new SqlDb();

  //for all meals in meals page
  // method
  //for restaurent 'restId','restaurent'

  Future<List<int>> getid() async {
    List<int> foodIds =
        await db.getRecommendedMeal(); // Example list of food IDs
    return foodIds;
  }

//variable and mapping

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Future<List<Food>> foodListFuture =
        getid().then((foodIds) => db.getFoodDetailsList(foodIds));
    if (FoodItem.checkoutList.isEmpty) {
      FoodItem.totalPrice = 0;
    }

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: '  Search for Meal or Restaurant',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      if (_searchController.text != '')
                        Get.to(SearchResultsPage(_searchController.text));
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // CustomAppbar(),
            HomePageTitle(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FoodList(foodListFuture),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Implement login logic here
                    Get.to(MealsPage('all'));
                  },
                  child: Text('Meals', style: TextStyle(fontSize: 22)),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement login logic here
                    Get.to(RestaurantsPage());
                  },
                  child: Text('Restaurants', style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Container(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Total price: \$${FoodItem.totalPrice}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      CheckoutList(FoodItem.checkoutList),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              onPressed: () => {
                                    //FoodItem.checkoutList.clear(),
                                    //FoodItem.totalPrice = 0,
                                    Navigator.pop(context),
                                    if (!FoodItem.checkoutList.isEmpty)
                                      {
                                        Get.to(CheckoutPage(
                                            FoodItem.checkoutList,
                                            FoodItem.totalPrice,
                                            widget.userName))
                                      }
                                  },
                              child: Text('Checkout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(
                            width: 50,
                          ),
                          OutlinedButton(
                              onPressed: () => {
                                    for (var i = 0;
                                        i < FoodItem.checkoutList.length;
                                        i++)
                                      {FoodItem.checkoutList[i].quantity = 0},
                                    FoodItem.checkoutList.clear(),
                                    FoodItem.totalPrice = 0,
                                    Navigator.pop(context),
                                  },
                              child: Text('Clear',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ],
                      )
                    ],
                  )),
                )
              },
          backgroundColor: Color.fromARGB(197, 182, 237, 255),
          elevation: 2,
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
            size: 34,
          )),
    );
  }
}
