import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/deps/carousel.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.7,
              child: SizedBox(
                width: 300,
                height: 300,
                // child: Image.asset('assets/images/tryon.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(180.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3d000000),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ))),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Now Wearing",
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomCarousel(banners: ['assets/images/tryon.png']),
      ],
    );
  }
}
