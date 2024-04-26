import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String userId = "";

  Future<void> login(String email, String password) async {
    final url = 'http://10.0.2.2:5000/login';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User logged in successfully');
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        userId = responseData['user_id'].toString();
        notifyListeners();
      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (error) {
      print('Error logging in: $error');
    }
  }

  Future<void> register(String email, String password, String first_name,
      double weight, double height) async {
    final url = 'http://10.0.2.2:5000/signup';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
      'first_name': first_name,
      'weight': weight,
      'height': height,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        userId = responseData['user_id'];

        notifyListeners();
      } else {
        print('Failed to register: ${response.statusCode}');
      }
    } catch (error) {
      print('Error registering: $error');
    }
  }

  String getUserId() {
    // return userId;
    return '1'; //hardcoded for now
  }
}
