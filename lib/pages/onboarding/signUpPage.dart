import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  //for signup logic
  final TextEditingController siginUserNameController = TextEditingController();
  final TextEditingController signPasswordController = TextEditingController();
  final TextEditingController signConfPasswordController =
      TextEditingController();
  final TextEditingController signMobileController = TextEditingController();
  final TextEditingController signAddrsController = TextEditingController();

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
              controller: siginUserNameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: signPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: signConfPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: signMobileController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: signAddrsController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the value as needed
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      Size(175, 75)) // Set the minimum size of the button
                  ),
              onPressed: () {
                // Implement signup logic here
                signUpLogicFunction();
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    ));
  }

  void signUpLogicFunction() {
    print("\n" + siginUserNameController.text);
    print("\n" + signPasswordController.text);
    print("\n" + signConfPasswordController.text);
    print("\n" + signMobileController.text);
    print("\n" + signAddrsController.text);
  }
}
