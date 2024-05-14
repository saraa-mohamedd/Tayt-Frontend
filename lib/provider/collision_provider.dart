import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tayt_app/models/clothing_item.dart';

class CollisionsProvider extends ChangeNotifier {
  String bodyMesh = '';
  bool isGenerating = false;

  ClothingItem topItem = ClothingItem(
    id: 0,
    frontImage: "",
    name: "",
    description: "",
    type: ClothingType.top,
    vendor: "",
    vendorLink: "",
  );
  ClothingItem bottomItem = ClothingItem(
    id: 0,
    frontImage: "",
    name: "",
    description: "",
    type: ClothingType.bottom,
    vendor: "",
    vendorLink: "",
  );

  Future<void> generateCollisions(
      ClothingItem top, ClothingItem bottom, String userId) async {
    // final url = 'http://.0.2.2:5000/collision';
    // final Map<String, dynamic> requestData = {
    //   'top_id': top.id,
    //   'bottom_id': bottom.id,
    //   'user_id': userId,
    // };

    // try {
    isGenerating = true;

    // final response = await http.post(
    //   Uri.parse(url),
    //   body: json.encode(requestData),
    //   headers: {'Content-Type': 'application/json'},
    // );
    notifyListeners();
    // if (response.statusCode == 200) {
    //   final responseData = json.decode(response.body) as Map<String, dynamic>;
    //   final topData = responseData['top'];
    //   final bottomData = responseData['bottom'];

    //   topItem = top;
    //   bottomItem = bottom;
    //  isGenerating = false;
    //   notifyListeners();
    // } else {
    //   print('Failed to generate collisions: ${response.statusCode}');
    //   isGenerating = false;
    //   notifyListeners();
    // }
  }
}
