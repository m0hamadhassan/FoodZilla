import 'package:flutter/material.dart';
import 'package:foodzilla/pages/splash/splashPage.dart';
import 'package:get/get.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(FoodZilla());
}

class FoodZilla extends StatelessWidget {
  const FoodZilla({Key? key});

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
                borderRadius:
                    BorderRadius.circular(50), // Setting border radius
              ),
            ),
            minimumSize: MaterialStateProperty.all(
                Size(150, 60)), // Setting minimum button size
          ),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor:
                Colors.black12), // Setting app bar background color
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple, // Setting primary color
          // Replace with your desired primary color
        ),
      ),
      debugShowCheckedModeBanner: false, // Hiding the debug banner
      home: SplashBody(), // Setting the initial page to be displayed
    );
  }
}
