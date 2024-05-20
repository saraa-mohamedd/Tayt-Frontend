import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:tayt_app/provider/favorites_provider.dart';

class HomeProvider extends ChangeNotifier {
  FavoritesProvider favoritesProvider = Get.put(FavoritesProvider());
  
  // Calls the backend to get recommendations for the user based on their likes
  Future<List<ClothingItem>> forYou(String userId) async {
    print("for you in action");

    final url =
        Uri.parse("http://127.0.0.1:5005/recommend_for_you?user_id=$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];

        List<ClothingItem> forYouItems = [];

        items.forEach((itemsData) {
          try {
            print("items data is $itemsData['id']");
            final item = ClothingItem(
              id: itemsData['id'],
              frontImage: itemsData['front_image'],
              name: itemsData['item_name'],
              description: itemsData['description'],
              type: itemsData['garment_type'] == 'top'
                  ? ClothingType.top
                  : ClothingType.bottom,
              vendor: itemsData['vendor'],
              vendorLink: itemsData['vendor_link'],
            );
            forYouItems.add(item);
          } catch (error) {
            print('Error getting for you items: $error');
          }
        });

        return forYouItems;
      } else {
        // Handle other status codes
        print('Failed to fetch clothing items: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle network or other general errors
      print('Error fetching clothing items: $error');
      return [];
    }
  }

  // Get list of trending items
  Future<List<ClothingItem>> trending() async {
    List<ClothingItem> trendingItems = [];

    Random random = Random();
    Set<int> numbers = {};
    while (numbers.length < 5) {
      int randomNumber = 1 + random.nextInt(99 + 1);
      numbers.add(randomNumber);
    }

    try {
      for (var number in numbers) {
        trendingItems.add(await favoritesProvider.fetchItem(number.toString()));
      }
    } catch (error) {
      print('Error fetching trending items: $error');
    }
    return trendingItems;
  }
}
