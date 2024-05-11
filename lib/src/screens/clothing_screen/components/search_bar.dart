import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';

class ClothingSearchBar extends StatelessWidget {
  const ClothingSearchBar({
    Key? key,
    required TextEditingController searchController,
    required this.onSearch,
  }) : _searchController = searchController, super(key: key);

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
                fontFamily: 'Helvetica Neue'),
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
                  borderRadius: BorderRadius.all(Radius.circular(40))),
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
          },
        ),
      ],
    );
  }
}
