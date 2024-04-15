import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:tayt_app/src/deps/carousel.dart';

class ClothingDetailsPage extends StatefulWidget {
  final String imagePath;
  final String name;
  final String description;
  final String storeName = 'Store and Brand Name';
  final String storeUrl = 'https://www.amazon.com/';

  // array of recommendations in the form of (imagePath, name, description) (can add more fields later if needed)
  final List<Tuple3<String, String, String>> recommendations = [
    Tuple3<String, String, String>(
        'assets/images/clothing/front2.jpeg', 'Clothing 2', 'Description 2'),
    Tuple3<String, String, String>(
        'assets/images/clothing/front22.jpeg', 'Clothing 22', 'Description 22'),
    Tuple3<String, String, String>(
        'assets/images/clothing/front3.jpeg', 'Clothing 3', 'Description 3'),
    Tuple3<String, String, String>(
        'assets/images/clothing/front13.jpeg', 'Clothing 13', 'Description 13'),
  ];

  ClothingDetailsPage({
    required this.imagePath,
    required this.name,
    required this.description,
  });

  @override
  _ClothingDetailsPageState createState() => _ClothingDetailsPageState();
}

class _ClothingDetailsPageState extends State<ClothingDetailsPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.6),
        surfaceTintColor: Color(0xfffaf9f6),
        title: Text(
          'Clothing Details',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontSize: 27,
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors
              .primaryColor, // Set the desired color for the back arrow
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        // _launchURL('https://www.amazon.com/');
                        // Add your onTap logic here
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors
                              .secondaryColor, // Background color for highlighting
                          borderRadius: BorderRadius.circular(
                              5.0), // Optional: rounded corners
                        ),
                        child: Text(
                          "Store and Brand Name ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.secondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.description,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.secondaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: SizedBox(
                          //make width percentage
                          width: MediaQuery.of(context).size.width * 0.64,
                          child: Text(
                            'Try Me',
                            style: TextStyle(
                                color: AppColors
                                    .primaryColor, // Set the desired text color here
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Icon(
                          isFavorite
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Try it with",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomCarousel(
                    banners: [],
                    width: 200,
                    height: 200,
                    viewportFraction: 0.55,
                    hasIndicator: false,
                    infscroll: false,
                    linkedImages: widget.recommendations,
                    linked: true,
                    bgColor: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}
