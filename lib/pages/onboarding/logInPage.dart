import 'package:flutter/material.dart';
import 'package:foodzilla/pages/onboarding/signUpPage.dart';
import 'package:get/get.dart';

import '../mainmenu/Landing.dart';

class LoginPage extends StatelessWidget {
  //for login logic
  final TextEditingController loginUserNameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  // final String credentials[2]={'mohamad','123456'};

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
                Get.to(() => LandingPage());
                loginLogicFunction();
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
  void loginLogicFunction() {
    print("\n" + loginUserNameController.text);
    print("\n" + loginPasswordController.text);
  }
}
