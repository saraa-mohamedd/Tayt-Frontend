import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/home_screen/components/body.dart';
import 'package:tayt_app/src/deps/colors.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 20,
          shadowColor: Colors.black.withOpacity(0.6),
          surfaceTintColor: Color(0xfffaf9f6),
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          title: Text(
            'Tayt',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: AppColors.primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.values[7],
                letterSpacing: -0.7),
          ),
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.barsStaggered,
                  color: AppColors.primaryColor),
              onPressed: () {},
            )
          ]),
      body: SingleChildScrollView(
        child: Body(),
      ),
    );
  }
}
