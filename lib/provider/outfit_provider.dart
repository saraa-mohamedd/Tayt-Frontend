import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/models/outfit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class OutfitProvider extends ChangeNotifier {
  List<Outfit> outfits = [];

  Future<void> fetchOutfits(String userId) async {
    try {
      final url1 = "http://10.0.2.2:5000/outfit/$userId";

      final response = await http.get(Uri.parse(url1));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        final List<dynamic> outfitss = responseData['outfits'];

        print("response is $responseData");

        outfits.clear(); // Clear existing favorites

        for (final outfitData in outfitss) {
          //get the top_id and bottom_id returned from the api
          final topId = outfitData['top_id'];
          final bottomId = outfitData['bottom_id'];

          ClothingItem top = ClothingItem(
            id: 0,
            frontImage: "",
            name: "",
            description: "",
            type: ClothingType.top,
            vendor: "",
            vendorLink: "",
          );

          ClothingItem bottom = ClothingItem(
            id: 0,
            frontImage: "",
            name: "",
            description: "",
            type: ClothingType.bottom,
            vendor: "",
            vendorLink: "",
          );

          if (topId != null) {
            final url2 = "http://10.0.2.2:5000/item/$topId";
            final response2 = await http.get(Uri.parse(url2));

            if (response2.statusCode == 200) {
              print("second url");
              final responseData2 = json.decode(response2.body);
              final topget = responseData2['item'];

              top = ClothingItem(
                id: topget['id'],
                frontImage: topget['front_image'],
                name: topget['item_name'],
                description: topget['description'],
                type: ClothingType.top,
                vendor: topget['vendor_name'],
                vendorLink: topget['vendor_link'],
              );
            }
          }

          print("before");

          if (bottomId != null) {
            final url3 = "http://10.0.2.2:5000/item/$bottomId";
            final response3 = await http.get(Uri.parse(url3));

            if (response3.statusCode == 200) {
              print("third url");
              final responseData3 = json.decode(response3.body);
              final botget = responseData3['item'];

              print(botget['id']);
              bottom = ClothingItem(
                id: botget['id'],
                frontImage: botget['front_image'],
                name: botget['item_name'],
                description: botget['description'],
                type: ClothingType.bottom,
                vendor: botget['vendor_name'],
                vendorLink: botget['vendor_link'],
              );
            }
          }

          if (topId == null && bottomId == null) {
            // Do nothing or handle this case separately
            print('No top or bottom found');
          } else if (topId == null) {
            print('No top found');
            final item = Outfit(
              id: outfitData['id'],
              items: [bottom],
            );
            outfits.add(item);
          } else if (bottomId == null) {
            print('No bottom found');
            final item = Outfit(
              id: outfitData['id'],
              items: [top],
            );
            outfits.add(item);
          } else {
            print("both found");

            final item = Outfit(
              id: outfitData['id'],
              items: [top, bottom],
            );
            outfits.add(item);
          }
        }

        print("outfits length is ${outfits.length}");
        for (var outfit in outfits) {
          print("outfit id is ${outfit.id}");
          for (var item in outfit.items) {
            print("item id is ${item.id}");
          }
        }

        notifyListeners();
      } else {
        // Handle other status codes
        print('Failed to fetch outfits: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching outfits: $error');
    }
  }

  Future<void> addToOutfit(String userId, int outfitId, String itemId) async {
    print("Adding item to outfit");
    try {
      final url = 'http://10.0.2.2:5000/item';
      print(url);
      final Map<String, dynamic> requestData = {
        'user_id': userId,
        'item_id': itemId,
        'outfit_id': outfitId,
      };
      print("resquest data is $requestData");
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );
      print("response is: ${response.body}");

      if (response.statusCode == 200) {
        print('Item added to outfit successfully');
        await fetchOutfits(userId); // await the fetchOutfits function
      } else {
        print('Failed to add item to outfit: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding item to outfit: $error');
    }
  }

  // void createOutfit(ClothingItem item) {
  //   outfits.add(Outfit(items: [item], id: outfits.length + 1));
  //   notifyListeners();
  // }

  Future<void> createOutfit(String userId, ClothingItem item) async {
    print("Creating outfit");
    try {
      final url = 'http://10.0.2.2:5000/outfit';
      final Map<String, dynamic> requestData = {
        'user_id': userId,
        'item_id': item.id,
      };

      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Outfit created successfully');
        await fetchOutfits(userId); // await the fetchOutfits function
      } else {
        print('Failed to create outfit: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating outfit: $error');
    }
  }

  // void removeFromOutfit(int index, int itemIndex) {
  //   Outfit outfit = outfits.firstWhere((outfit) => outfit.id == index);
  //   outfit.items.removeAt(itemIndex);

  //   if (outfit.items.isEmpty) {
  //     outfits.removeWhere((outfit) => outfit.id == index);
  //     notifyListeners();
  //     return;
  //   }

  //   // replace the outfit with the updated outfit
  //   outfits = outfits.map((outfit) {
  //     if (outfit.id == index) {
  //       return outfit;
  //     }
  //     return outfit;
  //   }).toList();
  //   notifyListeners();
  // }

  Future<void> removeFromOutfit(String userId, int outfitId, int itemId) async {
    print("Removing item from outfit");
    try {
      final url = 'http://10.0.2.2:5000/item';

      final Map<String, dynamic> requestData = {
        'user_id': '1',
        'item_id': itemId,
        'outfit_id': outfitId,
      };

      print("request data is $requestData");
      final response = await http.delete(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Item removed from outfit successfully');
        await fetchOutfits('1'); // await the fetchOutfits function
      } else {
        print('Failed to remove item from outfit: ${response.statusCode}');
      }
    } catch (error) {
      print('Error removing item from outfit: $error');
    }
  }

  List<Outfit> getOutfits() {
    return outfits;
  }

  List<Outfit> getIncompleteOutfits(ClothingItem clothingitem) {
    print("item type is ${clothingitem.type}");
    return outfits
        .where((outfit) =>
            outfit.items.length < 2 &&
            outfit.items[0].type != ClothingType.dress &&
            outfit.items[0].type != clothingitem.type)
        .toList();
  }
}
