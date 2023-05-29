import 'package:flutter/material.dart';
import 'package:foodzilla/pages/mainmenu/Landing.dart';
import 'package:foodzilla/pages/mainmenu/widgets/checkout_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../database/database.dart';
import '../mainmenu/models/food.dart';

class CheckoutPage extends StatelessWidget {
  List<Food> confirmationList;
  num totalPrice;
  SqlDb db = SqlDb();
  String userName;
  CheckoutPage(this.confirmationList, this.totalPrice, this.userName);

  Future<String> getAdd(String us, SqlDb db) async {
    String address = await db.getAddressByUsername(userName);
    return address;
  }

// Corrected code
//String? address = await getAddr(userName, db);

  @override
  Widget build(BuildContext context) {
    Future<String> address = db.getAddressByUsername(userName);
    Future<String> mobile = db.getMobileByUsername(userName);

    return Scaffold(
      appBar: AppBar(title: Text('Confirm Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // Wrap the body content with a Column widget
          children: [
            Expanded(
              flex: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckoutList(confirmationList),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Total price: \$$totalPrice",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FutureBuilder<String>(
                      future: address,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for the future to complete, show a loading indicator
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If an error occurred while fetching the address, display an error message
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Otherwise, display the retrieved address
                          String address = snapshot.data ?? '';
                          return Text('Address: $address',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ));
                        }
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  FutureBuilder<String>(
                      future: mobile,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for the future to complete, show a loading indicator
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If an error occurred while fetching the address, display an error message
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Otherwise, display the retrieved address
                          String mobile = snapshot.data ?? '';
                          return Text('Mobile: $mobile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ));
                        }
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Implement login logic here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Order confirmed"),
                            content: Text(
                              "Order confirmed succesfully \nWait for a phone call soon ",
                              style: TextStyle(fontSize: 18),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  confirmationList.clear();
                                  totalPrice = 0;
                                  Get.off(LandingPage(userName));
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child:
                        Text('Confirm Order', style: TextStyle(fontSize: 22)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
