import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;

class FavoritesProvider extends ChangeNotifier {
  List<ClothingItem> favorites = [];

  Future<void> fetchFavorites(String userId) async {
    try {
      final url = "http://10.0.2.2:5000/like/$userId";
      // print(url);

      final response = await http.get(Uri.parse(url));

      // print(response.body);
      if (response.statusCode == 200) {
        // print("Fetched favorites successfully");
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> likes = responseData['likes'];
        // print(likes);

        favorites.clear(); // Clear existing favorites

        likes.forEach((likeData) {
          final item = ClothingItem(
            id: likeData['id'],
            frontImage: likeData['front_image'],
            name: likeData['item_name'],
            description: likeData['description'],
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

  Future<void> likeItem(String userId, String itemId) async {
    final url = 'http://10.0.2.2:5000/like';
    final Map<String, dynamic> requestData = {
      'user_id': userId,
      'item_id': itemId,
    };

    // print(url);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      fetchFavorites(userId);

      if (response.statusCode == 200) {
        print('Item liked successfully');
      } else {
        print('Failed to like item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error liking item: $error');
    }
  }

  Future<void> unlikeItem(String userId, String itemId) async {
    final url = 'http://10.0.2.2:5000/unlike';
    final Map<String, dynamic> requestData = {
      'user_id': userId,
      'item_id': itemId,
    };

    print("unlikeing: ${url}");

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      fetchFavorites(userId);

      if (response.statusCode == 200) {
        print('Item unliked successfully');
      } else {
        print('Failed to unlike item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error unliking item: $error');
    }
  }

  Future<ClothingItem> fetchItem(String itemId) async {
    try {
      final url = "http://10.0.2.2:5000/item/$itemId";
      print(url);

      final response = await http.get(Uri.parse(url));

      // print(response.body);
      if (response.statusCode == 200) {
        // print("Fetched item successfully");
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final dynamic itemData = responseData['item'];

        final item = ClothingItem(
          id: itemData['id'],
          frontImage: itemData['front_image'],
          name: itemData['item_name'],
          description: itemData['description'],
          type: ClothingType.top,
        );

        return item;
      } else {
        // Handle other status codes
        throw Exception('Failed to fetch item: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching item: $error');
    }
  }

  // void addToFavorites(ClothingItem item) {
  //   if (!favorites.contains(item)) {

  //     favorites.add(item);
  //   }
  //   notifyListeners();
  // }

  void getItem(int itemid) {}

  void addToFavorites(String userId, String itemId) {
    Future<ClothingItem> item = fetchItem(itemId);
    if (!favorites.contains(item)) {
      likeItem(userId, itemId);
    }
  }

  void removeFromFavorites(String userId, String itemId) {
    print("in remove from favorites");
    // Future<ClothingItem> item = fetchItem(itemId);
    // if (favorites.contains(item)) {
    unlikeItem(userId, itemId);
    // }
  }

  bool isFavorite(String userId, String itemId) {
    List<int> itemIds = favorites.map((item) => item.id).toList();
    print("itemIds: $itemIds");
    print("itemId: $itemId");
    if (itemIds.contains(int.parse(itemId))) {
      return true;
    }
    return false;
  }

  void toggleFavorite(String userId, String itemId) {
    print('isFavorite: ${isFavorite(userId, itemId)}');
    if (isFavorite(userId, itemId)) {
      removeFromFavorites(userId, itemId);
    } else {
      addToFavorites(userId, itemId);
    }
  }

  List<ClothingItem> getFavorites() {
    return favorites;
  }
}
