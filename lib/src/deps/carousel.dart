import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tayt_app/config/size_config.dart';
import 'package:tayt_app/controllers/carousel_controllers.dart';
import 'package:tayt_app/src/deps/carousel_counter.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/clothing_details_page.dart';
import 'package:tuple/tuple.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    required this.banners,
    this.width,
    this.height,
    this.viewportFraction = 0.95,
    this.hasIndicator = true,
    this.infscroll = true,
    this.linkedImages = const [],
    this.linked = false,
    this.bgColor = AppColors.secondaryColor,
    super.key,
  });

  final bool hasIndicator;
  final double viewportFraction;
  final double? width, height;
  final List<String> banners;
  final List<Tuple3<String, String, String>> linkedImages;
  final bool? infscroll;
  final bool linked;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomCarouselController());
    return Column(
      children: [
        CarouselSlider(
          items: linked
              ? linkedImages
                  .map((url) => CarouselImage(
                        imageUrl: url.item1,
                        width: width,
                        height: height,
                        backgroundColor: bgColor.withOpacity(0.5),
                        onPressed: () {
                          // Navigate to ClothingDetailsPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClothingDetailsPage(
                                imagePath: url.item1,
                                name: url.item2,
                                description: url.item3,
                              ),
                            ),
                          );
                        },
                      ))
                  .toList()
              : banners
                  .map((url) => CarouselImage(
                      imageUrl: url,
                      width: width,
                      height: height,
                      backgroundColor:
                          AppColors.secondaryColor.withOpacity(0.5)))
                  .toList(),
          options: CarouselOptions(
            viewportFraction: viewportFraction,
            onPageChanged: (index, _) => controller.updateIndex(index),
            height: height,
            enableInfiniteScroll: infscroll!,
            padEnds: false,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: hasIndicator
                ? Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < banners.length; i++)
                          CircularContainer(
                            width: 20,
                            height: 4,
                            backgroundColor: controller.currentIndex.value == i
                                // ? Color(0xff233d4d)
                                ? AppColors.secondaryColor
                                : Colors.grey.withOpacity(0.5),
                            margin: EdgeInsets.only(right: 10),
                          )
                      ],
                    ))
                : SizedBox()),
      ],
    );
  }
}

class CarouselImage extends StatelessWidget {
  const CarouselImage({
    this.width,
    this.height,
    required this.imageUrl,
    this.backgroundColor = Colors.white,
    this.padding,
    this.onPressed,
    super.key,
  });

  final double? width, height;
  final String imageUrl;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: 20,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
