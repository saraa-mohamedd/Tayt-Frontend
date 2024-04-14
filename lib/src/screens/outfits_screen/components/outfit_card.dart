import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/clothing_details_page.dart';
import 'package:tayt_app/src/screens/tryon_screen/tryon_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';

class OutfitCard extends StatelessWidget {
  final Tuple2<Tuple3<String, String, String>, Tuple3<String, String, String>>
      outfitItems;
  final int numItems;

  const OutfitCard({
    Key? key,
    required this.outfitItems,
    required this.numItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClothingDetailsPage(
                            imagePath: outfitItems.item1.item1,
                            name: outfitItems.item1.item2,
                            description: outfitItems.item1.item3,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          outfitItems.item1.item1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Container(
                  height: 170,
                  width: 120,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: numItems == 2
                      ? GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClothingDetailsPage(
                                imagePath: outfitItems.item2.item1,
                                name: outfitItems.item2.item2,
                                description: outfitItems.item2.item3,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              outfitItems.item2.item1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      :
                      // add a dashed border container with a plus icon
                      // to indicate that there are more images
                      Container(
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
                                outfitItems: outfitItems,
                                numItems: numItems,
                              )),
                    );
                  },
                ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Colors.blue),
                //       fixedSize: MaterialStateProperty.all(Size(50, 50))),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => TryOnScreen()),
                //     );
                //   },
                //   child: Text('Add to Cart'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
