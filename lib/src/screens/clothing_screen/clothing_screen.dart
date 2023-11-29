import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClothingScreen extends StatelessWidget {
  static String routeName = '/clothing-screen';
  const ClothingScreen({Key? key}) : super(key: key);

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
            'Clothing',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: Colors.black.withOpacity(0.9),
                fontSize: 36,
                fontWeight: FontWeight.values[7],
                letterSpacing: -0.7),
          ),
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.circleQuestion),
              onPressed: () {},
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.heart),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/wardrobe-outline.svg',
                width: 26,
                height: 26,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ]),
      body: SingleChildScrollView(
        child: Body(),
      ),
    );
  }
}
