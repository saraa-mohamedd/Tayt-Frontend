import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MeasurementsProvider extends ChangeNotifier {
  String bodyMeshFile = '';
  bool isGenerating = false;
  bool bodyGenerated = false;
  String bodyMesh = '';

  bool get getIsGenerating {
    return isGenerating;
  }

  void startGenerating() {
    isGenerating = true;
    bodyGenerated = false;
    notifyListeners();
  }

  // Future<void> genrateBodyMeshUsingHMR(String userId, String image){
  //   final url = 'http://10.0.2.2:5002/infer';
  //   try{

  //   } catch (error) {
  //     print('Error generating body mesh: $error');
  //     throw error;
  //   }

  // }

  Future<void> generateBodyMeshUsingMeasurements(
      Measurements measurements, String userId) async {
    // double chest, double waist, double hips, String userId) async {
    final url = 'http://10.0.2.2:5001/generate';
    Map<String, dynamic> request = {
      "chest": measurements.chest,
      "waist": measurements.waist,
      "hips": measurements.hips,
      "height": measurements.height,
      "weight": measurements.weight,
      "gender": measurements.gender,
      "user_id": userId
    };
    final headers = {'Content-Type': 'application/json'};
    isGenerating = true;
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response data: $responseData');
      isGenerating = false;
      bodyGenerated = true;
      notifyListeners();
    } else {
      print('Failed to render mesh: ${response.statusCode}');
    }
  }

  Future<String> getBodyMesh(String userId) async {
    final url = 'http://10.0.2.2:5000/body/$userId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final bodyMeshData = utf8.decode(base64Decode(responseData['body']));
        // Update the bodyMesh property
        bodyMesh = bodyMeshData;

        print('Body mesh: $bodyMesh');

        // // Notify listeners or do any other necessary operations
        // notifyListeners();

        return bodyMesh;
      } else {
        print('Failed to fetch body mesh: ${response.statusCode}');
        throw Exception('Failed to fetch body mesh: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching body mesh: $error');
      throw error; // Rethrow the error
    }
  }

  String returnBodyMesh() {
    return bodyMesh;
  }
}
