import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../onboarding/logInPage.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
    goToNextView();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(37, 34, 61, 1.0),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: fadingAnimation!,
                child: Image.asset('assets/images/splashViewImage.png'),
              )
            ],
          ),
        ));
  }

  void goToNextView() {
    Future.delayed(Duration(seconds: 3), () {
      //after delay and splash go to login page
      Get.off(() => LoginPage(), transition: Transition.fade);
    });
  }
}
