import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
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
  bool isOutfitsToggled = false;
  bool isFavorite = false;


  void toggleOutfitsVisibility() {
    setState(() {
      isOutfitsToggled = !isOutfitsToggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    String name = widget.name;
    String description = widget.description;
    String storeName = widget.storeName;
    String storeUrl = widget.storeUrl;

    OutfitProvider outfitProvider = Provider.of<OutfitProvider>(context);
    List<Tuple2<int, List<OutfitItem>>> available_outfits =
        outfitProvider.getIncompleteOutfits();
    List<Tuple3<String, String, String>> recommendations =
        widget.recommendations;

    void getOutfits() {
      // change state to display all available outfits
      setState(() {
        available_outfits = outfitProvider.getIncompleteOutfits();
      });
    }

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
                          // display all available outfits
                          getOutfits();
                          toggleOutfitsVisibility();
                          // render row of outfit cards
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
                            'Add to Outfit',
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
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: isOutfitsToggled
                        ? 250
                        : 0, // Set height based on visibility
                    padding: isOutfitsToggled
                        ? EdgeInsets.symmetric(vertical: 20)
                        : EdgeInsets.zero,
                    child: isOutfitsToggled
                        ? Container(
                            // color: AppColors.primaryColor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: AppColors.primaryColor,
                            ),
                            child: ListView.builder(
                              itemCount: available_outfits.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return index < available_outfits.length
                                    ? GestureDetector(
                                        onTap: () {
                                          toggleOutfitsVisibility();
                                          outfitProvider.addToOutfit(
                                              available_outfits[index].item1,
                                              OutfitItem(
                                                  imagePath: imagePath,
                                                  name: name,
                                                  description: description));
                                          // Add your onTap logic here
                                        },
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    // Optionally, you can add other decorations like a border or shadow here
                                                  ),
                                                  width: 150,
                                                  height: 200,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: Image.asset(
                                                      available_outfits[index]
                                                          .item2[0]
                                                          .imagePath,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 200,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.5), // Grey overlay
                                                ), // Grey overlay
                                              ),
                                              Icon(
                                                Icons.add,
                                                size: 40,
                                                color: Colors
                                                    .white, // Plus sign icon
                                              ),
                                            ]),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          toggleOutfitsVisibility();
                                          outfitProvider.createOutfit(
                                              OutfitItem(
                                                  imagePath: imagePath,
                                                  name: name,
                                                  description: description));
                                          // Add your onTap logic here
                                        },
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Container(
                                                  height: 200,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.grey
                                                        .withOpacity(
                                                            0.5), // Grey overlay
                                                  ), // Grey overlay
                                                ),
                                              ),
                                              Icon(
                                                Icons.add_circle_outline,
                                                size: 40,
                                                color: Colors
                                                    .white, // Plus sign icon
                                              ),
                                            ]),
                                      );
                              },
                            ),
                          )
                        : SizedBox
                            .shrink(), // Hide the ListView when not visible
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
