import 'package:flutter/material.dart';
import 'package:tayt_app/provider/outfit_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ClothingItem> favorites = [];

  void addToFavorites(ClothingItem item) {
    favorites.add(item);
    notifyListeners();
  }

  void removeFromFavorites(ClothingItem item) {
    favorites.remove(item);
    notifyListeners();
  }

  bool isFavorite(ClothingItem item) {
    return favorites.contains(item);
  }

  void toggleFavorite(ClothingItem item) {
    if (isFavorite(item)) {
      removeFromFavorites(item);
    } else {
      addToFavorites(item);
    }
  }

  List<ClothingItem> getFavorites() {
    return favorites;
  }
}
