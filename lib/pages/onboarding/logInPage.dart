import 'package:flutter/material.dart';
import 'package:foodzilla/pages/onboarding/signUpPage.dart';
import 'package:get/get.dart';

import '../mainmenu/Landing.dart';

class LoginPage extends StatelessWidget {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 1000),
    content: const Text(
      'wrong username or password',
      style: TextStyle(color: Colors.white, fontSize: 15),
    ),
    backgroundColor: (Colors.red),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
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
              onPressed: () {
                // Implement login logic here
                loginLogicFunction(context, loginUserNameController.text,
                    loginPasswordController.text);
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
  void loginLogicFunction(context, String userName, String passwrd) {
    //this list will be from database
    List<String> creds = ['mohamad', '1234'];

    if (userName == creds[0] && passwrd == creds[1]) {
      Get.to(() => LandingPage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    print("\n" + loginUserNameController.text);
    print("\n" + loginPasswordController.text);
  }
}
