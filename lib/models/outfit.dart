import 'package:tayt_app/models/clothing_item.dart';

class Outfit {
  final List<ClothingItem> items;
  final int id;
  final int rating = 0;

  Outfit({required this.items, required this.id});
}
