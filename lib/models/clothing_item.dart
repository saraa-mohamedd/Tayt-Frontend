import 'dart:typed_data';

enum ClothingType { top, bottom, dress }

class ClothingItem {
  final int id;
  final String frontImage;
  final String name;
  final String description;
  final bool isLiked;
  final ClothingType type;

  ClothingItem({
    required this.id,
    required this.frontImage,
    required this.name,
    required this.description,
    this.isLiked = false,
    required this.type,
  });
}
