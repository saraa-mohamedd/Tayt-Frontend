import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/models/user.dart';

class AuthProvider extends ChangeNotifier {
  String userId = "";
  List<ClothingItem> recentItems = [];

  void addRecentItem(ClothingItem item) {
    recentItems.removeWhere((element) => element.id == item.id);
    recentItems.insert(0, item);
    print(recentItems);
    if (recentItems.length > 10) {
      recentItems.removeAt(9);
    }
    notifyListeners();
  }

  // API call for login
  Future<void> login(String email, String password) async {
    print("called login");
    final url = 'http://127.0.0.1:5000/login';
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
        // throw Error(); //uncomment when we integrate login in server
        // throw AuthenticationException('Invalid email or password');
      }
    } catch (error) {
      print('Error logging in: $error');
      // throw Error(); //uncomment when we integrate login in server
      // throw AuthenticationException('Invalid email or password');
    }
  }

  // API call for register
  Future<void> register(String email, String password, double weight,
      double height, String gender) async {
    print("called register");
    final url = 'http://127.0.0.1:5000/signup';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
      'first_name': "dang",
      'weight': weight as double,
      'height': height as double,
      'gender': gender
    };

    try {
      print("signing up");
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        userId = responseData['user_id'].toString();
        print("userid is $userId");
        print("response data is $responseData");
        notifyListeners();
      } else {
        print('Failed to register: ${response.statusCode}');
      }
    } catch (error) {
      print('Error registering: $error');
    }
  }
  
  // getter for userId
  String getUserId() {
    return userId;
  }
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}
