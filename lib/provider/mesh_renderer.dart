import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MeasurementsProvider extends ChangeNotifier {
  final bodymesh = '';
  final url = 'http://10.0.2.2:5000/generate';

  Future<void> renderUsingMeasurements(Measurements measurements) async {
    Map<String, dynamic> request = {
      "gender": measurements.gender,
      "height": measurements.height,
      "weight": measurements.weight,
      "chest": measurements.chest,
      "waist": measurements.waist,
      "hips": measurements.hips
    };
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));
    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response data: $responseData');
    } else {
      print('Failed to render mesh: ${response.statusCode}');
    }

    // bodymesh = response.body;
    // notifyListeners();
  }
}
