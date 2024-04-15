import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/outfits_screen/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/tryon_screen/tryon_screen.dart';

class OutfitsScreen extends StatelessWidget {
  static String routeName = '/clothing-screen';
  OutfitsScreen({Key? key}) : super(key: key);

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
            'My Outfits',
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
              icon: FaIcon(FontAwesomeIcons.circleQuestion,
                  color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ]),
      body: Body(),
    );
  }
}
