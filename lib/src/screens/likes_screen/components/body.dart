import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/deps/colors.dart';

class FavoriteItem {
  final String id;
  final String name;

  FavoriteItem({required this.id, required this.name});
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<FavoriteItem> _favoritesList = [
    FavoriteItem(id: '1', name: 'Favorite 1'),
    FavoriteItem(id: '2', name: 'Favorite 2'),
    FavoriteItem(id: '3', name: 'Favorite 3'),
    FavoriteItem(id: '4', name: 'Favorite 4'),
    FavoriteItem(id: '5', name: 'Favorite 5'),
    FavoriteItem(id: '6', name: 'Favorite 6'),
    FavoriteItem(id: '7', name: 'Favorite 7'),
    FavoriteItem(id: '8', name: 'Favorite 8'),
    FavoriteItem(id: '9', name: 'Favorite 9'),
    FavoriteItem(id: '10', name: 'Favorite 10'),
  ];

  // Function to remove an item from the favorites list
  void removeFromFavorites(String id) {
    setState(() {
      _favoritesList.removeWhere((item) => item.id == id);
    });
  }

  // Function to generate image path based on the ID
  String generateImagePath(String id) {
    return 'assets/images/clothing/front$id.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _favoritesList.length,
      itemBuilder: (context, index) {
        final favoriteItem = _favoritesList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.5), // Set background color
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  generateImagePath(favoriteItem.id),
                  width: 65,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container();
                  },
                ),
              ),
              title: Text(
                favoriteItem.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Details of ${favoriteItem.name}',
              ),
              trailing: IconButton(
                icon: Icon(FontAwesomeIcons.solidHeart, color: AppColors.primaryColor),
                onPressed: () {
                  removeFromFavorites(favoriteItem.id);
                },
              ),
              onTap: () {
                // Handle tap on the favorite item
              },
            ),
          ),
        );
      },
    );
  }
}
