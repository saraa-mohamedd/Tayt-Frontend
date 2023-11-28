import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/body_screen/components/body.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/mesh_renderer.dart';

class BodyScreen extends StatelessWidget {
  static String routeName = '/body-screen';
  const BodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: MeasurementsProvider(),
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            shadowColor: Colors.black.withOpacity(0.6),
            surfaceTintColor: Color(0xfffaf9f6),
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            // backgroundColor: Colors.teal,
            actions: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.barsStaggered),
                onPressed: () {},
              ),
              // add more IconButton
            ],
            title: Text(
              'My Body',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    textBaseline: TextBaseline.alphabetic,
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 36,
                    fontWeight: FontWeight.values[7],
                    letterSpacing: -0.7,
                    // shadows: [
                    //   Shadow(
                    //     offset: Offset(2.0, 1.0),
                    //     blurRadius: 0,
                    //     color: Color(0xffecd06f),
                    //   ),
                    // ]
                  ),
            ),
          ),
          body: SingleChildScrollView(
            child: Body(),
          ),
        ));
  }
}
