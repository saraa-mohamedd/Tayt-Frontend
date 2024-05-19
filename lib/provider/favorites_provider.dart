import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;

class FavoritesProvider extends ChangeNotifier {
  List<ClothingItem> favorites = [];

  Future<void> fetchFavorites(String userId) async {
    try {
      final url = "http://127.0.0.1:5000/like/$userId";
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
            vendor: likeData['vendor'],
            vendorLink: likeData['vendor_link'],
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
    final url = 'http://127.0.0.1:5000/like';
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
    final url = 'http://127.0.0.1:5000/unlike';
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
      final url = "http://127.0.0.1:5000/item/$itemId";
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
          type: itemData['garment_type'] == 'top'
              ? ClothingType.top
              : ClothingType.bottom,
          //if vendor is null then set it to empty string
          vendor: itemData['vendor'] == null ? "Zara" : itemData['vendor'],
          vendorLink: itemData['item_link'] == null
              ? "https://www.zara.com/eg/en/"
              : itemData['item_link'],
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

  bool isFavorite(String userId, String itemId) {
    List<int> itemIds = favorites.map((item) => item.id).toList();
    if (itemIds.contains(int.parse(itemId))) {
      return true;
    }
    return false;
  }

  void toggleFavorite(String userId, String itemId) {
    if (isFavorite(userId, itemId)) {
      unlikeItem(userId, itemId);
    } else {
      likeItem(userId, itemId);
    }
  }

  List<ClothingItem> getFavorites() {
    return favorites;
  }
}
