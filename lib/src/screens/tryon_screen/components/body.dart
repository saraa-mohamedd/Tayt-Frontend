import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/deps/carousel.dart';
import 'package:tuple/tuple.dart';
import 'package:ionicons/ionicons.dart';

class Body extends StatefulWidget {
  // final Tuple2<Tuple3<String, String, String>, Tuple3<String, String, String>>
  //     outfitItems;
  final Outfit outfit;
  final int numItems;

  const Body({
    Key? key,
    required this.outfit,
    required this.numItems,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Outfit outfit = widget.outfit;
    int numItems = widget.numItems;

    List<ClothingItem> linkedItems = [];
    if (outfit.items.isNotEmpty) {
      linkedItems = numItems == 1
          ? [outfit.items[0]]
          : [outfit.items[0], outfit.items[1]];
    }
    // List<Tuple3<String, String, String>> linkedImages = [];
    // if (outfit.items.isNotEmpty) {
    //   linkedImages = numItems == 1
    //       ? [
    //           Tuple3(outfit.items[0].imagePath, outfit.items[0].name,
    //               outfit.items[0].description),
    //         ]
    //       : [
    //           Tuple3(outfit.items[0].imagePath, outfit.items[0].name,
    //               outfit.items[0].description),
    //           Tuple3(outfit.items[1].imagePath, outfit.items[1].name,
    //               outfit.items[1].description),
    //         ];
    // }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
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
          Positioned(
            top: 20,
            right: 10,
            child: IconButton(
              icon: Icon(
                Ionicons.calculator,
                size: 30,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                // call api to get rating of the outfit
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Outfit Rating'),
                      content: RichText(
                        text: TextSpan(
                          text: 'Hmm.. this outfit is a \n',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.primaryColor),
                          children: [
                            TextSpan(
                              text: '72.5!',
                              style: TextStyle(
                                fontSize: 50,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.secondaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ]),
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
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomCarousel(
              banners: [],
              width: 200,
              height: 200,
              viewportFraction: 0.55,
              hasIndicator: false,
              infscroll: false,
              linkedImages: linkedItems,
              linked: true,
              bgColor: AppColors.primaryColor,
            )),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         BodyScreen(), // Replace with your desired screen
                //   ),
                // );
              },
              icon: Icon(
                Ionicons.shirt_outline,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
              ),
              label: Text(
                'Try Another Outfit',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
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
