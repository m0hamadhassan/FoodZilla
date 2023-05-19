import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../database/database.dart';

class SignupPage extends StatelessWidget {
  //for signup logic
  final TextEditingController siginUserNameController = TextEditingController();
  final TextEditingController signPasswordController = TextEditingController();
  final TextEditingController signConfPasswordController =
      TextEditingController();
  final TextEditingController signEmailController = TextEditingController();
  final TextEditingController signMobileController = TextEditingController();
  final TextEditingController signAddrsController = TextEditingController();
  //for connecting database

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
            SizedBox(
              height: 16.0,
              width: 16.0,
            ),
            TextFormField(
              controller: signConfPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: signEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              obscureText: false,
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
              onPressed: () async {
                // Implement signup logic here
                signUpLogicFunction(context);
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    ));
  }

//show dialogue function
  void normalDialogueShow(context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
  }

//signUp logic function
  void signUpLogicFunction(context) async {
    SqlDb db = new SqlDb();
    String username = siginUserNameController.text;
    String email = signEmailController.text;
    String password = signPasswordController.text;
    String passwordConfirm = signConfPasswordController.text;
    String address = signAddrsController.text;
    String phoneNumber = signMobileController.text;
    bool emailExists = await db.isEmailAlreadyExists(email);
    bool usernameExists = await db.isEmailAlreadyExists(username);

    if (username.length < 5) {
      normalDialogueShow(
          context, 'Error', 'Short username, must be at least 5 characters');
    } else if (password != passwordConfirm) {
      normalDialogueShow(
          context, 'Error', 'Password doesn\'t match, Enter password again');
    } else if (emailExists) {
      // Email already exists in the database, show an error dialog
      normalDialogueShow(context, 'Error',
          'Email already exists. Please choose a different email');
    } else if (usernameExists) {
      // Email already exists in the database, show an error dialog
      normalDialogueShow(context, 'Error',
          'Username already exists. Please choose a different Username');
    } else {
      await db.insertData('''
                INSERT INTO "users" (username, email, password, address, phone_number)
                VALUES
                ('$username','$email','$password','$address','$phoneNumber');
                ''');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successful'),
            content: Text('Account Created Successfully, Login now'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.back();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
