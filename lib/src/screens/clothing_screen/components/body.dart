import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/search_bar.dart';
import 'clothing_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _searchController = TextEditingController();
  int _currentPage = 0;
  final _pageSize = 10; // Number of items per page
  final _clothingItems = List.generate(100, (index) => 'Clothing ${index + 1}');
  List<bool> _isHeartFilledList = List.filled(100, false); // List to track the filled state of each heart

  List<String> _getCurrentPageItems() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize) < _clothingItems.length
        ? (startIndex + _pageSize)
        : _clothingItems.length;
    return _clothingItems.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> currentPageItems = _getCurrentPageItems();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          ClothingSearchBar(searchController: _searchController),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                //childAspectRatio: 0.9, // Adjust this value to control the size of the grid items
              ),
              itemCount: currentPageItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to ClothingDetailsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClothingDetailsPage(
                          imagePath:
                              'assets/images/clothing/front${_currentPage * _pageSize + index + 1}.jpeg',
                          name:
                              'Clothing ${_currentPage * _pageSize + index + 1}',
                          description:
                              'Description of the clothing item ${_currentPage * _pageSize + index + 1}',
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
                          child: Image.asset(
                            'assets/images/clothing/front${_currentPage * _pageSize + index + 1}.jpeg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
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
                              color: AppColors.secondaryColor.withOpacity(
                                  0.7), // Semi-transparent background for text
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clothing ${_currentPage * _pageSize + index + 1}',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Store/Brand Name',
                                  style: TextStyle(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.7),
                                    fontSize: 14,
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
                            icon: _isHeartFilledList[index]
                                ? FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: AppColors.primaryColor,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: AppColors.primaryColor,
                                  ),
                            onPressed: () {
                              setState(() {
                                _isHeartFilledList[index] =
                                    !_isHeartFilledList[index]; // Toggle the filled state of the heart icon
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
          Container(
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
                  icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
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
                  onPressed:
                      (_currentPage + 1) * _pageSize >= _clothingItems.length
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
