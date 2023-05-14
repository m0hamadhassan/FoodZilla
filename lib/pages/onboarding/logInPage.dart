import 'package:flutter/material.dart';
import 'package:foodzilla/pages/onboarding/signUpPage.dart';
import 'package:get/get.dart';

import '../../database/database.dart';
import '../mainmenu/Landing.dart';

class LoginPage extends StatelessWidget {
//database connection variable
  sqlDb db = new sqlDb();

  final snackBar = SnackBar(
    duration: Duration(milliseconds: 1000),
    content: const Text(
      'Wrong Username or Password',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    backgroundColor: (Colors.red),
  );
  //for login logic
  final TextEditingController loginUserNameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 65.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loginImage.png',
              height: 150,
              width: 150,
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: loginUserNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: loginPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                // Implement login logic here
                // List<Map> response2 =
                //     await db.checkPassword(loginUserNameController.text);
                // print(response2[0]['password']);
                loginLogicFunction(context, db);
              },
              child: Text('Login', style: TextStyle(fontSize: 25)),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Still not a member ?!',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
                TextButton(
                    onPressed: () {
                      // Implement login logic here
                      Get.to(() => SignupPage());
                    },
                    child: Text('Register Now',
                        style: TextStyle(fontSize: 18, color: Colors.blue)))
              ],
            )
          ],
        ),
      ),
    ));
  }

//LOGIN LOGIC FUNCTION
  void loginLogicFunction(context, sqlDb db) async {
    //this list will be from database
    String userName = loginUserNameController.text;
    String passwrd = loginPasswordController.text;

    dynamic returnPass = await db.checkPassword(userName);
    if (await db.isUsernameExists(userName) == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Username not found'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (returnPass != passwrd) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Incorrect Password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        Get.off(LandingPage());
      }
    }
    print(returnPass);

    // print("\n" + loginUserNameController.text);
    // print("\n" + loginPasswordController.text);
  }
}
