import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/tab_view.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/search_bar.dart';

class Body extends StatelessWidget {
  Body({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              ClothingSearchBar(searchController: _searchController),
              SizedBox(
                height: 50,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text('Garments'),
                      ),
                      Tab(
                        child: Text('Outfits'),
                      ),
                    ],
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.black,
                    // overlayColor: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    // SingleChildScrollView(
                    Container(
                      // height: ,
                      // width: 20,
                      color: AppColors.secondaryColor,
                      child: Center(
                        child: Text(
                          'Coming Soon!\n[single garments based on search prompt]',
                        ),
                      ),
                    ),

                    // second tab bar viiew widget
                    Container(
                      color: AppColors.secondaryColor,
                      child: Center(
                        child: Text(
                          'Coming Soon!\n[Entire outfits based on search prompt]',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ClothingTabs(),
          // TabBar(
          //   controller: tabController,
          //   tabs: [
          //     Tab(
          //       text: 'Garments',
          //     ),
          //     Tab(
          //       text: 'Outfits',
          //     ),
          //   ],
          //   labelColor: Colors.black,
          // ),
          // ClothingTabs()
        ));
  }
}
