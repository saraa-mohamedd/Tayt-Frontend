import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BodyProvider extends ChangeNotifier {
  String bodyMesh = '';

  // Api call to generate body measurements from image
  Future<void> generateBodyMeshUsingHMR(
    String userId,
    File image,
  ) async {
    final url = 'http://127.0.0.1:5002/infer';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromBytes(
      'image_file',
      await image.readAsBytes(),
      filename: 'image.jpg', 
    ));

    request.fields['user_id'] = userId;

    try {
      print('in try block of generateBodyMeshUsingHMR ${request}');
      final response = await request.send();

      if (response.statusCode == 200) {

        notifyListeners();
      } else {
        print('Failed to render mesh: ${response.statusCode}');
      }
    } catch (error) {
      print('Error generating body mesh: $error');
      throw error;
    } catch (error) {
      print('Error generating body mesh: $error');
      throw error;
    }
  }

  // Editing body measurements in User table
  Future<void> editBodyMesh(
      String userId, double height, double weight, String gender) async {
    final url = 'http://127.0.0.1:5000/edit';
    try {
      print("editing body mesh");
      Map<String, dynamic> request = {
        "height": height,
        "weight": weight,
        "gender": gender,
        "user_id": userId
      };
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(request));

      if (response.statusCode == 200) {
        print("editing worked");
        notifyListeners();
      } else {
        print('Failed to render mesh: ${response.statusCode}');
      }
    } catch (error) {
      print('Error generating body mesh: $error');
      throw error;
    }
  }

  // Calling MICE to generate 3D Body Mesh
  Future<void> generateBodyMeshUsingMeasurements(
      Measurements measurements, String userId) async {
    final url = 'http://127.0.0.1:5001/generate';
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
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));

    if (response.statusCode == 200) {
      print("in mice");
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response data: $responseData');
      notifyListeners();
    } else {
      print('Failed to render mesh: ${response.statusCode}');
    }
  }

  // Fetch the body mesh from the backend
  Future<String> getBodyMesh(String userId) async {
    print('mice userid: $userId ');
    final url = 'http://127.0.0.1:5000/body/$userId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final bodyMeshData = utf8.decode(base64Decode(responseData['body']));
        bodyMesh = bodyMeshData;


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

  // Body Mesh Getter
  String returnBodyMesh() {
    return bodyMesh;
  }
}
