enum ClothingType { top, bottom, dress }

class ClothingItem {
  final String imagePath;
  final String name;
  final String description;
  final bool isLiked;
  final ClothingType type;

  ClothingItem({
    required this.imagePath,
    required this.name,
    required this.description,
    this.isLiked = false,
    required this.type,
  });
}
