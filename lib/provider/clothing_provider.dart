import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;

class ClothingProvider extends ChangeNotifier {
  List<ClothingItem> _clothingItems = [];

  Future<void> fetchClothingItems(String userId) async {
    print("here fetching");
    final Map<String, dynamic> requestData = {
      'user_id': userId,
    };

    try {
      print(requestData);
      final url = Uri.parse("http://10.0.2.2:5000/item?user_id=$userId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];

        _clothingItems.clear(); // Clear existing clothing items

        //PRINT RESPONSE
        // print('Response data: $responseData');
        // print('Items: $items');
        items.forEach((itemsData) {
          try {
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
            _clothingItems.add(item);
          } catch (error) {
            // Log error for individual item
            print(itemsData['vendor']);
            print('Error decoding image for item ${itemsData['id']}: $error');
          }
        });

        notifyListeners();
      } else {
        // Handle other status codes
        print('Failed to fetch clothing items: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other general errors
      print('Error fetching clothing items: $error');
    }
  }

  List<ClothingItem> get clothingItems {
    return [..._clothingItems];
  }

  Future<List<ClothingItem>> searchEngine(String userQuery) {
    final url = Uri.parse("http://10.0.2.2:5000/search");

    try{
      
    }
  }

  Future<List<ClothingItem>> getCompatibleRecommendations(
      String clothingItemId) async {
    final url = Uri.parse(
        "http://10.0.2.2:5000/itemrecommendation?item_id=${clothingItemId}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];

        List<ClothingItem> compatibleItems = [];

        items.forEach((itemsData) {
          try {
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
            compatibleItems.add(item);
          } catch (error) {
            print(
                'Error getting compatible recommendations for ${clothingItemId}: $error');
          }
        });

        return compatibleItems;
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
}
