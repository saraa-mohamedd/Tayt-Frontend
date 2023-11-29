import 'package:flutter/material.dart';
import 'package:tayt_app/src/screens/home_screen/components/carousel.dart';

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
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomCarousel(
              banners: [
                'assets/images/splash_screen_bg.jpg',
                'assets/images/splash_screen_bg.jpg',
                'assets/images/splash_screen_bg.jpg'
              ],
              width: 370,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Trending Products',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            const SizedBox(
              height: 15,
            ),
            CustomCarousel(
                banners: [
                  'assets/images/splash_screen_bg.jpg',
                  'assets/images/splash_screen_bg.jpg',
                  'assets/images/splash_screen_bg.jpg'
                ],
                height: 120,
                width: 150,
                hasIndicator: false,
                viewportFraction: 0.45),
            SizedBox(
              height: 15,
            ),
            Text('Recommended For You',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w500,
                    )),
            SizedBox(height: 20),
            CustomCarousel(banners: [
              'assets/images/splash_screen_bg.jpg',
              'assets/images/splash_screen_bg.jpg',
              'assets/images/splash_screen_bg.jpg'
            ]),
          ],
        ));
  }
}
