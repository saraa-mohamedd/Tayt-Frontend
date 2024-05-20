//Used to keep track of user's body measurements for the 3D Body Generation
import 'package:flutter/material.dart';

class Measurements {
  String gender;
  double height;
  double weight;
  double chest;
  double waist;
  double hips;

  Measurements({
    Key? key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.chest,
    required this.waist,
    required this.hips,
  });
}
