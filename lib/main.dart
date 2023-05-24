import 'package:flutter/material.dart';
import 'package:foodzilla/pages/splash/splashPage.dart';

import 'package:get/get.dart';

void main() {
  runApp(FoodZilla());
}

class FoodZilla extends StatelessWidget {
  const FoodZilla({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Setting the theme for the entire application
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Customizing the style of elevated buttons
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(150, 60)),
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.black12),
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          // Replace with your desired primary color
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashBody(), // Setting the initial page to be displayed
    );
  }
}
