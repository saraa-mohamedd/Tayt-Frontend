import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/components/mesh_render.dart';

import 'package:tayt_app/src/screens/home_screen/home_screen.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.7,
              child: MeshRender(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(170.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3d000000),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ))),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Doesn\'t seem right? ',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 17.0, bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.ruler,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color(0xffecd06f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
              ),
              label: Text(
                'Back to Body Measurements',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
