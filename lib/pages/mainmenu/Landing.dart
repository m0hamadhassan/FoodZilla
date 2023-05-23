import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzilla/database/database.dart';
import 'package:foodzilla/pages/mainmenu/widgets/checkout_list.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_item.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../restaurantsPage/restaurentPage.dart';
import 'constants/colors/colors.dart';
import 'models/food.dart';
import 'widgets/home_page_title.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //int _selectedIndex = 0;

  TextEditingController _searchController = TextEditingController();
  //var selected = 0;
  SqlDb db = new SqlDb();

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  Future<List<int>> getid() async {
    List<int> foodIds =
        await db.getRecommendedMeal(); // Example list of food IDs
    return foodIds;
  }

  void _performSearch(String searchText) {
    // Perform search logic here
    print('Searching for: $searchText');
  }
  //for all meals in meals page
  // method
  //for restaurent 'restId','restaurent'

// Future<List<int>> getid() async {
//     List<int> foodIds =
//         await db.getTableIds('id', 'meals'); // Example list of food IDs
//     return foodIds;
//   }

//variable and mapping
// Future<List<Food>> foodListFuture =
//         getid().then((foodIds) => db.getFoodDetailsList(foodIds));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    Future<List<Food>> foodListFuture =
        getid().then((foodIds) => db.getFoodDetailsList(foodIds));

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black26,
      //   selectedItemColor: Colors.deepPurple,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Meals',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Restaurants',
      //     ),
      //   ],
      // ),
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Expanded(
      //         child: TextField(
      //           controller: _textEditingController,
      //           decoration: InputDecoration(
      //             filled: true,
      //             hintText: 'Search with Meal or Restaurant',
      //             border: InputBorder.none,
      //           ),
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           String searchQuery = _textEditingController.text;
      //           // Perform search action here
      //           print('Search query: $searchQuery');
      //         },
      //         icon: Icon(Icons.search),
      //       ),
      //     ],
      //   ),
      // ),
      // backgroundColor: kBackground,
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [leftGradient, rightGradient],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _searchController,
                onChanged: _performSearch,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // CustomAppbar(),
            HomePageTitle(),
            Expanded(
              child: FoodList(foodListFuture),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement login logic here
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
            SizedBox(height: 10.0),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => {
      //           showModalBottomSheet(
      //             context: context,
      //             builder: (_) => Container(
      //                 child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 25,
      //                 ),
      //                 Text(
      //                   "Total price: \$${FoodItem.totalPrice}",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 SizedBox(height: 20),
      //                 CheckoutList(FoodItem.checkoutList),
      //                 OutlinedButton(
      //                     onPressed: () => {
      //                           FoodItem.checkoutList.clear(),
      //                           FoodItem.totalPrice = 0,
      //                           Navigator.pop(context),
      //                           /*
      //                       for (int i = 0;
      //                       i < recommendedFoods.length;
      //                       i++)
      //                         {recommendedFoods[i].quantity = 0},*/
      //                         },
      //                     child: Text('Checkout',
      //                         style: TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 18,
      //                           fontWeight: FontWeight.bold,
      //                         )))
      //               ],
      //             )),
      //           )
      //         },
      //     backgroundColor: kBlendColor,
      //     elevation: 2,
      //     child: Icon(
      //       Icons.shopping_bag_outlined,
      //       color: Colors.black,
      //       size: 34,
      //     )),
    );
  }
}
