import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/favorites_provider.dart';
import 'package:tayt_app/provider/clothing_provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/search_bar.dart';
import 'clothing_details_page.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _searchController = TextEditingController();
  int _currentPage = 0;
  final _pageSize = 10; // Number of items per page

  @override
  void initState() {
    super.initState();
    String userId =
        Provider.of<AuthProvider>(context, listen: false).getUserId();
    // Fetch clothing items when the Body widget is initialized
    Provider.of<ClothingProvider>(context, listen: false)
        .fetchClothingItems(userId);
    Provider.of<FavoritesProvider>(context, listen: false)
        .fetchFavorites(userId);
  }

  List<ClothingItem> _getCurrentPageItems(List<ClothingItem> allClothingItems) {
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize) < allClothingItems.length
        ? (startIndex + _pageSize)
        : allClothingItems.length;
    return allClothingItems.sublist(startIndex, endIndex);
  }

  Future<void> _performSearch(String query) async {
    await Provider.of<ClothingProvider>(context, listen: false)
        .searchEngine(query);
    // Reset current page to 0 after performing search
    setState(() {
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the list of clothing items from the provider
    final authProvider = Provider.of<AuthProvider>(context);
    final clothingProvider = Provider.of<ClothingProvider>(context);

    final List<ClothingItem> currentPageItems = _getCurrentPageItems(
      clothingProvider.searchItems.isNotEmpty
          ? clothingProvider.searchItems
          : clothingProvider.clothingItems,
    );

    FavoritesProvider favesProvider = Provider.of<FavoritesProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          ClothingSearchBar(
            searchController: _searchController,
            onSearch: _performSearch, // Pass the search function callback
          ),
          SizedBox(height: 20),
          clothingProvider.isFetching
              ? Container(
                  // fill the entire screen height
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )))
              : currentPageItems.isEmpty
                  ? Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Text(
                          'No items found',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: currentPageItems.length,
                        itemBuilder: (context, index) {
                          final clothingItem = currentPageItems[index];
                          final bool isLiked = favesProvider.isFavorite(
                              authProvider.getUserId(),
                              clothingItem.id.toString());
                          return GestureDetector(
                            onTap: () {
                              // Navigate to ClothingDetailsPage
                              authProvider.addRecentItem(clothingItem);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClothingDetailsPage(
                                    clothingItem: clothingItem,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.memory(
                                      base64Decode(clothingItem.frontImage),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            clothingItem.name,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            clothingItem.vendor,
                                            style: TextStyle(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.7),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 8,
                                    child: IconButton(
                                      icon: isLiked
                                          ? Icon(Icons.favorite,
                                              color: AppColors.primaryColor)
                                          : Icon(Icons.favorite_border,
                                              color: AppColors.primaryColor),
                                      onPressed: () async {
                                        setState(() {
                                          favesProvider.toggleFavorite(
                                              authProvider.getUserId(),
                                              clothingItem.id.toString());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          SizedBox(height: 0),
          clothingProvider.isFetching
              ? SizedBox(height: 0)
              : Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: AppColors.primaryColor),
                        onPressed: _currentPage == 0
                            ? null
                            : () {
                                setState(() {
                                  _currentPage--;
                                });
                              },
                      ),
                      Text('Page ${_currentPage + 1}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                      IconButton(
                        icon: Icon(Icons.arrow_forward,
                            color: AppColors.primaryColor),
                        onPressed: (_currentPage + 1) * _pageSize >=
                                clothingProvider.clothingItems.length
                            ? null
                            : () {
                                setState(() {
                                  _currentPage++;
                                });
                              },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
