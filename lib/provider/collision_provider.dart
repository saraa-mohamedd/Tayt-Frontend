import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/models/outfit.dart';

class CollisionsProvider extends ChangeNotifier {
  String bodyMesh = '';
  bool isGenerating = false;
  bool hasOutfit = false;

  get getIsGenerating => isGenerating;

  // Declaring items for collision 
  ClothingItem topItem = ClothingItem(
    id: -1,
    frontImage: "",
    name: "",
    description: "",
    type: ClothingType.top,
    vendor: "",
    vendorLink: "",
  );
  ClothingItem bottomItem = ClothingItem(
    id: -1,
    frontImage: "",
    name: "",
    description: "",
    type: ClothingType.bottom,
    vendor: "",
    vendorLink: "",
  );

  void setCurrentOutfit(Outfit outfit) {
    hasOutfit = true;
    topItem = outfit.items[0];
    bottomItem = outfit.items[1];

    notifyListeners();
  }

  // Call the HOOD Api in order to place clothing on 3D Body
  Future<void> generateCollisions(
      Outfit outfit, String userId, String size) async {
    setCurrentOutfit(outfit);
    final Map<String, dynamic> requestData = {
      'outfit_id': outfit.id,
      'user_id': userId,
    };
    int sendSize = 0;
    if (size == "S") {
      sendSize = 0;
    } else if (size == "M") {
      sendSize = 1;
    } else if (size == "L") {
      sendSize = 2;
    } else if (size == "XL") {
      sendSize = 3;
    }
    final url =
        'http://127.0.0.1:5004/api/hood/${outfit.id}/${userId}/${sendSize}';

    try {
      isGenerating = true;

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      notifyListeners();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        // topItem = top;
        // bottomItem = bottom;
        isGenerating = false;
        notifyListeners();
      } else {
        print('Failed to generate collisions: ${response.statusCode}');
        isGenerating = false;
        notifyListeners();
      }
    } catch (error) {
      print('Error generating collisions: $error');
      isGenerating = false;
      notifyListeners();
    }
  }
}
