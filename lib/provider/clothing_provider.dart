import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

class ClothingProvider extends ChangeNotifier {
  List<ClothingItem> _clothingItems = [];

  Future<void> fetchClothingItems() async {
    try {
      final url = "http://10.0.2.2:5000/item";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> items = responseData['items'];

        _clothingItems.clear(); // Clear existing clothing items

        items.forEach((itemsData) {
          final item = ClothingItem(
            id: itemsData['id'],
            imagePath: "assets/images/clothing/front1.jpeg", //fix this
            name: itemsData['item_name'],
            description: itemsData['description'],
            type: ClothingType.top, //this too
          );
          _clothingItems.add(item);
        });

        notifyListeners();
      } else {
        // Handle other status codes
        print('Failed to fetch clothing items: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching clothing items: $error');
    }
  }

  List<ClothingItem> get clothingItems {
    return [..._clothingItems];
  }
}
