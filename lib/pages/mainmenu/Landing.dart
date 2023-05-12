import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzilla/pages/mainmenu/widgets/checkout_list.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_item.dart';
import 'package:foodzilla/pages/mainmenu/widgets/food_list.dart';
import 'constants/colors/colors.dart';
import 'models/food.dart';
import 'widgets/home_page_title.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var selected = 0;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                String searchQuery = _textEditingController.text;
                // Perform search action here
                print('Search query: $searchQuery');
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      // backgroundColor: kBackground,
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [leftGradient, rightGradient],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomAppbar(),
            HomePageTitle(),
            Expanded(
              child: FoodList(recommendedFoods),
            )
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
                      OutlinedButton(
                          onPressed: () => {
                                FoodItem.checkoutList.clear(),
                                FoodItem.totalPrice = 0,
                                Navigator.pop(context),
                              },
                          child: Text('Checkout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )))
                    ],
                  )),
                )
              },
          backgroundColor: kBlendColor,
          elevation: 2,
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
            size: 34,
          )),
    );
  }
}
