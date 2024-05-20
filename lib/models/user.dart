// Keep track of User information
import 'package:flutter/material.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:tayt_app/models/clothing_item.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final Measurements measurements;
  final String bodyMesh;
  //final List<ClothingItem> favorites = [];

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.measurements,
    required this.bodyMesh,
  });
}
