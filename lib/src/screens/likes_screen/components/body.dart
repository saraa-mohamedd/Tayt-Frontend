import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/favorites_provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/clothing_screen/components/clothing_details_page.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    String userId =
        Provider.of<AuthProvider>(context, listen: false).getUserId();
    // Fetch favorites when the Body widget is initialized
    Provider.of<FavoritesProvider>(context, listen: false)
        .fetchFavorites(userId);
  }

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favesProvider = Provider.of<FavoritesProvider>(context);
    List<ClothingItem> faves = favesProvider.favorites;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return ListView.builder(
      itemCount: faves.length,
      itemBuilder: (context, index) {
        final favoriteItem = faves[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor
                  .withOpacity(0.5), // Set background color
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64Decode(favoriteItem.frontImage),
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
              subtitle: Text(favoriteItem.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  )),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: AppColors.primaryColor),
                onPressed: () {
                  setState(() {
                    favesProvider.unlikeItem(
                        authProvider.getUserId(), favoriteItem.id.toString());
                    // faves.removeAt(index);
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothingDetailsPage(
                      clothingItem: favoriteItem,
                    ),
                  ),
                );
                // Handle tap on the favorite item
              },
            ),
          ),
        );
      },
    );
  }
}
