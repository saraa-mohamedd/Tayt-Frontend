import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';

class ClothingSearchBar extends StatelessWidget {
  const ClothingSearchBar({
    Key? key,
    required TextEditingController searchController,
    required this.onSearch,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 15,
              fontFamily: 'Helvetica Neue',
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              hintText: 'Search...',
              hintStyle: TextStyle(fontFamily: 'Helvetica Neue'),
              // Add a clear button to the search bar
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
              // Add a search icon or button to the search bar
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('Search query: ${_searchController.text}');
                  // Call the onSearch callback with the query
                  onSearch(_searchController.text);
                },
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 243, 220, 166),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.filter_list_outlined, size: 30),
          onPressed: () {
            // Perform filtering here if needed
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.9),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSizeButton(context, 'S'),
                          _buildSizeButton(context, 'M'),
                          _buildSizeButton(context, 'L'),
                          _buildSizeButton(context, 'XL'),
                        ],
                      ),
                      SizedBox(height: 30),
                      
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSizeButton(BuildContext context, String size) {
    return GestureDetector(
      onTap: () {
        // Handle size selection
        //call generateCollisions and send the size
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
