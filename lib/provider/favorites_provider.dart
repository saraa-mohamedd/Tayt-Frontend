import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;

class FavoritesProvider extends ChangeNotifier {
  List<ClothingItem> favorites = [];

  Future<void> fetchFavorites(String userId) async {
    print("here");
    const url = "http://127.0.0.1:5000/like/1";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Fetched favorites successfully");
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> likes = responseData['likes'];

        favorites.clear(); // Clear existing favorites

        likes.forEach((likeData) {
          final item = ClothingItem(
            imagePath: "assets/images/liked_clothing/image1.jpeg", //fix this
            name: likeData['item_name'],
            description: likeData['description'],
            isLiked: true,
            type: ClothingType.top,
          );
          favorites.add(item);
        });

        notifyListeners();
      } else {
        // Handle other status codes
        print('Failed to fetch favorites: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching favorites: $error');
    }
  }

  void addToFavorites(ClothingItem item) {
    favorites.add(item);
    notifyListeners();
  }

  void removeFromFavorites(ClothingItem item) {
    favorites.remove(item);
    notifyListeners();
  }

  bool isFavorite(ClothingItem item) {
    return favorites.contains(item);
  }

  void toggleFavorite(ClothingItem item) {
    if (isFavorite(item)) {
      removeFromFavorites(item);
    } else {
      addToFavorites(item);
    }
  }

  List<ClothingItem> getFavorites() {
    return favorites;
  }
}
