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

  Future<void> generateCollisions(Outfit outfit, String userId) async {
    setCurrentOutfit(outfit);
    final Map<String, dynamic> requestData = {
      'outfit_id': outfit.id,
      'user_id': userId,
    };
    final url = 'http://10.0.2.2:5004/api/hood/${outfit.id}/${userId}/1';

    try {
      isGenerating = true;

      final response = await http.get(
        Uri.parse(url),
        // body: json.encode(requestData),
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
