import 'package:flutter/material.dart';

class HomePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Recommended Meals',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
            ),
          ]),
    );
  }
}
