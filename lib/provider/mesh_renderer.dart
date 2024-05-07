import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MeasurementsProvider extends ChangeNotifier {
  String bodyMeshFile = '';
  bool isGenerating = false;

  String fetchBodyMeshPath(String userId) {
    bodyMeshFile = 'assets/meshes/result.obj';
    // notifyListeners();
    return bodyMeshFile;
  }

  bool get getIsGenerating {
    return isGenerating;
  }

  void startGenerating() {
    isGenerating = true;
    notifyListeners();
  }

  Future<void> generateBodyMeshUsingMeasurements(
      double chest, double waist, double hips, String userId) async {
    final url = 'http://10.0.2.2:5001/generate';
    Map<String, dynamic> request = {
      "chest": chest,
      "waist": waist,
      "hips": hips,
      "user_id": userId
    };
    final headers = {'Content-Type': 'application/json'};
    isGenerating = true;
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response data: $responseData');
    } else {
      print('Failed to render mesh: ${response.statusCode}');
    }
  }

  Future<void> getBodyMesh(String userId) async {
    final url = 'http://10.0.2.2:5000/body/${userId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        print('Response data: $responseData');
        print('here');
        print(
            'writing to file: ${utf8.decode(base64Decode(responseData['body']))}');

        // final file = File(
        //   '/home/mahdy/Desktop/Thesis-Flutter-Frontend/lib/test.txt',
        // );

        // // await file
        // //     .writeAsString(utf8.decode(base64Decode(responseData['body'])));
        // // read file and print
        // final contents = await file.readAsString();
        // print('contents: $contents');

        isGenerating = false;

        notifyListeners();
      } else {
        print('Failed to fetch body mesh: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching body mesh: $error');
    }
  }
}
