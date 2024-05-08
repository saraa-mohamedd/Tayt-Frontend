import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
// import 'package:tayt_app/src/screens/home_screen/components/carousel.dart';
import 'package:tayt_app/src/deps/carousel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome!',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w700,
                    )),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Trending Themes',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomCarousel(
              banners: [
                'assets/images/secondarycolor_swatch.png',
                'assets/images/secondarycolor_swatch.png',
                'assets/images/secondarycolor_swatch.png',
                'assets/images/secondarycolor_swatch.png',
              ],
              width: 348,
              height: 200,
              viewportFraction: 0.95,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Trending Products',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor)),
            const SizedBox(
              height: 10,
            ),
            CustomCarousel(
                banners: [
                  'assets/images/clothing/front2.jpeg',
                  'assets/images/clothing/front6.jpeg',
                  'assets/images/clothing/front16.jpeg',
                ],
                height: 130,
                width: 150,
                hasIndicator: false,
                viewportFraction: 0.42,
                infscroll: false),
            SizedBox(
              height: 15,
            ),
            Text('Recommended For You',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w600,
                    )),
            const SizedBox(height: 10),
            CustomCarousel(
              banners: [
                'assets/images/secondarycolor_swatch.png',
                'assets/images/secondarycolor_swatch.png',
                'assets/images/secondarycolor_swatch.png',
              ],
              width: 150,
              height: 130,
              infscroll: true,
              viewportFraction: 0.42,
            ),
          ],
        ));
  }
}
