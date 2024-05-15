import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/clothing_details_page.dart';
import 'package:tayt_app/src/screens/tryon_screen/tryon_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayt_app/provider/collision_provider.dart';
import 'package:tayt_app/models/outfit.dart';

class OutfitCard extends StatefulWidget {
  final Outfit outfit;
  final int numItems;

  const OutfitCard({
    Key? key,
    required this.outfit,
    required this.numItems,
  }) : super(key: key);

  @override
  _OutfitCardState createState() => _OutfitCardState();
}

void printFullString(String str) {
  const int chunkSize = 100;
  for (int i = 0; i < str.length; i += chunkSize) {
    print(str.substring(
        i, i + chunkSize < str.length ? i + chunkSize : str.length));
  }
}

class _OutfitCardState extends State<OutfitCard> {
  @override
  void initState() {
    super.initState();
    final userId =
        Provider.of<AuthProvider>(context, listen: false).getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final collisionsProvider =
        Provider.of<CollisionsProvider>(context, listen: false);
    // String userId = authProvider.getUserId();
    // printFullString(widget.outfit.items[0].frontImage);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 170,
                  width: 120,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.outfit.items[0].frontImage != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClothingDetailsPage(
                                  clothingItem: widget.outfit.items[0],
                                ),
                              ),
                            );
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.outfit.items[0].frontImage != null
                              ? Image.memory(
                                  base64Decode(
                                      widget.outfit.items[0].frontImage),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<OutfitProvider>(context, listen: false)
                                .removeFromOutfit(
                                    authProvider.getUserId(),
                                    widget.outfit.id,
                                    widget.outfit.items[0].id);
                          },
                          child: const Icon(
                            FontAwesomeIcons.trashAlt,
                            color: Color.fromARGB(255, 150, 45, 45),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 170,
                  width: 120,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.numItems == 2
                      ? Stack(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClothingDetailsPage(
                                    clothingItem: widget.outfit.items[1],
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: widget.outfit.items[1].frontImage != null
                                    ? Image.memory(
                                        base64Decode(
                                            widget.outfit.items[1].frontImage),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<OutfitProvider>(context,
                                          listen: false)
                                      .removeFromOutfit(
                                          authProvider.getUserId(),
                                          widget.outfit.id,
                                          widget.outfit.items[1].id);
                                },
                                child: const Icon(
                                  FontAwesomeIcons.trashAlt,
                                  color: Color.fromARGB(255, 150, 45, 45),
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 10,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                        ),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: widget.outfit.items.length == 2
                        ? MaterialStateProperty.all(AppColors.secondaryColor)
                        : MaterialStateProperty.all(
                            AppColors.secondaryColor.withOpacity(0.7)),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/hanger.svg',
                    width: 32,
                    height: 32,
                    color: widget.outfit.items.length == 2
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.5),
                  ),
                  onPressed: widget.outfit.items.length == 2
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.secondaryColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Please Pick a Size for your Outfit',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildSizeButton(context, 'S',
                                            collisionsProvider, authProvider),
                                        _buildSizeButton(context, 'M',
                                            collisionsProvider, authProvider),
                                        _buildSizeButton(context, 'L',
                                            collisionsProvider, authProvider),
                                        _buildSizeButton(context, 'XL',
                                            collisionsProvider, authProvider),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      : () => null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeButton(BuildContext context, String size,
      CollisionsProvider collisionsProvider, AuthProvider authProvider) {
    return GestureDetector(
      onTap: () {
        // Handle size selection
        print('Size selected: $size');
        collisionsProvider.generateCollisions(
            widget.outfit, authProvider.getUserId(), size);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TryOnScreen(
                    outfit: widget.outfit,
                    numItems: widget.numItems,
                  )),
        );
        // navigate to try on screen in nav bar
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
