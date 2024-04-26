import 'dart:typed_data';

enum ClothingType { top, bottom, dress }

class ClothingItem {
  final int id;
  final String frontImage;
  final String name;
  final String description;
  final ClothingType type;
  final String vendor;
  final String vendorLink;

  ClothingItem({
    required this.id,
    required this.frontImage,
    required this.name,
    required this.description,
    required this.type,
    required this.vendor,
    required this.vendorLink,
  });
}
