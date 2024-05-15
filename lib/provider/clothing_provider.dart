import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:http/http.dart' as http;

class ClothingProvider extends ChangeNotifier {
  List<ClothingItem> _clothingItems = [];
  bool isFetching = false;

  Future<void> fetchClothingItems(String userId) async {
    print("here fetching");
    final Map<String, dynamic> requestData = {
      'user_id': userId,
    };

    try {
      print(requestData);
      final url = Uri.parse("http://10.0.2.2:5000/item?user_id=$userId");
      isFetching = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];
        isFetching = false;

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
              vendorLink: !(itemsData['item_link'] == null)
                  ? itemsData['item_link']
                  : '',
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

  Future<void> searchEngine(String userQuery) async {
    print("search engine in action");

    // Construct the URL with the query string
    final url = Uri.parse("http://10.0.2.2:5000/search?query=$userQuery");

    try {
      //send the query in the body
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({'query': userQuery}),
      // );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];

        _clothingItems.clear(); // Clear existing clothing items

        // PRINT RESPONSE
        print('Response data: $responseData');
        print('Items: $items');

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
        print('Failed to complete search: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other general errors
      print('Error fetching search items: $error');
    }
  }

  Future<List<ClothingItem>> getCompatibleRecommendations(
      String clothingItemId) async {
    print("getting compatible recommendations");
    final url =
        Uri.parse("http://10.0.2.2:5005/recommend?item_id=$clothingItemId");

    try {
      print("before reponse");
      //send the id in the body
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({'item_id': clothingItemId}),
      // );

      final response = await http.get(url);

      print("response issss $response");

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
            print("id is ${itemsData['id']}");
            print("front image is ${itemsData['front_image']}");
            print("name is ${itemsData['item_name']}");
            print("description is ${itemsData['description']}");
            print("type is ${itemsData['garment_type']}");
            print("vendor is ${itemsData['vendor']}");
            print("vendor link is ${itemsData['vendor_link']}");
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
