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
        theme: ThemeData.dark().copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
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
            appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
            colorScheme: ColorScheme.dark(primary: Colors.deepPurple
                // Replace with your desired primary color
                )),
        debugShowCheckedModeBanner: false,
        home: SplashBody());
    //edit one
  }
}
