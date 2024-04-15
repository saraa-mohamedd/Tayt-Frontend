import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/likes_screen/components/body.dart';

class LikedClothingScreen extends StatelessWidget {
  static String routeName = '/liked-clothing-screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        shadowColor: Colors.black.withOpacity(0.6),
        surfaceTintColor: Color(0xfffaf9f6),
        toolbarHeight: 60,
        title: Text(
          'Favorited Items',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              textBaseline: TextBaseline.alphabetic,
              color: AppColors.primaryColor,
              fontSize: 36,
              fontWeight: FontWeight.values[7],
              letterSpacing: -0.7),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Body(),
    );
  }
}
