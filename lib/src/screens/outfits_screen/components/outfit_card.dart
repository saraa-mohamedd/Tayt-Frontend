import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/clothing_details_page.dart';
import 'package:tayt_app/src/screens/tryon_screen/tryon_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';
import 'package:tayt_app/models/outfit.dart';

class OutfitCard extends StatefulWidget {
  final Outfit outfit;
  // final Tuple2<Tuple3<String, String, String>, Tuple3<String, String, String>>
  //     outfitItems;
  final int numItems;

  const OutfitCard({
    Key? key,
    required this.outfit,
    required this.numItems,
  }) : super(key: key);

  @override
  _OutfitCardState createState() => _OutfitCardState();
}

class _OutfitCardState extends State<OutfitCard> {
  @override
  Widget build(BuildContext context) {
    OutfitProvider outfitProvider = Provider.of<OutfitProvider>(context);
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 170,
                    width: 120,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothingDetailsPage(
                              // imagePath: widget.outfit.items[0].imagePath,
                              // name: widget.outfit.items[0].name,
                              // description: widget.outfit.items[0].description,
                              clothingItem: widget.outfit.items[0],
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            base64Decode(widget.outfit.items[0].frontImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            outfitProvider.removeFromOutfit(
                                widget.outfit.id, 0);
                          },
                          child: Icon(
                            FontAwesomeIcons.trashAlt,
                            color: Color.fromARGB(255, 150, 45, 45),
                            size: 16,
                          ),
                        ),
                      ),
                    ])),
                Container(
                  height: 170,
                  width: 120,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.numItems == 2
                      ? Stack(children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClothingDetailsPage(
                                  clothingItem: widget.outfit.items[1],
                                  // imagePath: widget.outfit.items[1].imagePath,
                                  // name: widget.outfit.items[1].name,
                                  // description:
                                  //     widget.outfit.items[1].description,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                base64Decode(widget.outfit.items[1].frontImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                outfitProvider.removeFromOutfit(
                                    widget.outfit.id, 1);
                              },
                              child: Icon(
                                FontAwesomeIcons.trashAlt,
                                color: Color.fromARGB(255, 150, 45, 45),
                                size: 16,
                              ),
                            ),
                          ),
                        ])
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 10,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.question_mark_rounded,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                        ),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.secondaryColor),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/hanger.svg',
                    width: 32,
                    height: 32,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TryOnScreen(
                                outfit: widget.outfit,
                                numItems: widget.numItems,
                              )),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
