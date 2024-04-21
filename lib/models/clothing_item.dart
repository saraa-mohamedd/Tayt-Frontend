enum ClothingType { top, bottom, dress }

class ClothingItem {
  final int id;
  final String imagePath;
  final String name;
  final String description;
  final bool isLiked;
  final ClothingType type;

  ClothingItem({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    this.isLiked = false,
    required this.type,
  });
}
