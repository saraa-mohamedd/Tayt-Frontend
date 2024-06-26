import 'dart:ui';
import 'package:tayt_app/models/outfit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/src/screens/tryon_screen/components/body.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tuple/tuple.dart';

class TryOnScreen extends StatelessWidget {
  static String routeName = '/tryon-screen';
  final Outfit outfit;
  // final Tuple2<Tuple3<String, String, String>, Tuple3<String, String, String>>
  //     outfitItems;
  final int numItems;

  const TryOnScreen({
    Key? key,
    required this.outfit,
    required this.numItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        shadowColor: Colors.black.withOpacity(0.6),
        surfaceTintColor: Color(0xfffaf9f6),
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.barsStaggered,
                // color: Color(0xff708d81)
                color: AppColors.primaryColor),
            onPressed: () {},
          ),
          // add more IconButton
        ],
        title: Text(
          'Let\'s Do It!',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: AppColors.primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.values[7],
                letterSpacing: -0.7,
              ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(color: AppColors.secondaryColor),
              child: Body(
                outfit: outfit,
                numItems: numItems,
              ))),
    );
  }
}
