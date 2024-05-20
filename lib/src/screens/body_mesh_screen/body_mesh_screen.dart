import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/components/body.dart';
import 'package:tayt_app/src/deps/colors.dart';

class BodyMeshScreen extends StatelessWidget {
  static String routeName = '/body-screen';
  const BodyMeshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        shadowColor: Colors.black.withOpacity(0.6),
        surfaceTintColor: Color(0xfffaf9f6),
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.barsStaggered,
                color: AppColors.secondaryColor),
            onPressed: () {},
          ),
        ],
        title: Text(
          'My Body',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: AppColors.secondaryColor,
                fontSize: 36,
                fontWeight: FontWeight.values[7],
                letterSpacing: -0.7,
              ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Body())),
    );
  }
}
