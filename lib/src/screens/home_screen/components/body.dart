import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/clothing_provider.dart';
import 'package:tayt_app/provider/home_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/deps/carousel.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> recommendations = [];
    ClothingProvider clothingProvider = Provider.of<ClothingProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 15),
          Text(
            'Trending Themes',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          CustomCarousel(
            banners: [
              'assets/images/themes/theme1.png',
              'assets/images/themes/theme2.png',
              'assets/images/themes/theme3.png',
              'assets/images/themes/theme4.png',
              'assets/images/themes/theme5.png',
            ],
            width: 348,
            height: 200,
            viewportFraction: 0.95,
          ),
          const SizedBox(height: 20),
          const Text(
            'Trending Products',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Helvetica Neue',
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<List<ClothingItem>>(
            future: homeProvider.trending(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                );
              } else if (snapshot.hasError) {
                return Text('Error getting trending: ${snapshot.error}');
              } else {
                return CustomCarousel(
                  banners: [],
                  width: 200,
                  height: 200,
                  viewportFraction: 0.55,
                  hasIndicator: false,
                  infscroll: false,
                  linkedImages: snapshot.data!,
                  linked: true,
                  bgColor: AppColors.primaryColor,
                );
              }
            },
          ),
          SizedBox(height: 15),
          Text(
            'Recommended For You',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 10),
          FutureBuilder<List<ClothingItem>>(
            future: homeProvider.forYou(authProvider.getUserId()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error getting recommendations: ${snapshot.error}');
              } else {
                return CustomCarousel(
                  banners: [],
                  width: 200,
                  height: 200,
                  viewportFraction: 0.55,
                  hasIndicator: false,
                  infscroll: false,
                  linkedImages: snapshot.data!,
                  linked: true,
                  bgColor: AppColors.secondaryColor,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
