import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/models/outfit.dart';

class OutfitProvider extends ChangeNotifier {
  List<Outfit> outfits = [];

  void addToOutfit(int index, ClothingItem item) {
    if (outfits.any((outfit) => outfit.id == index)) {
      outfits = outfits.map((outfit) {
        if (outfit.id == index) {
          outfit.items.add(item);
        }
        return outfit;
      }).toList();
    } else {
      outfits.add(Outfit(items: [], id: index));
    }

    notifyListeners();
  }

  void createOutfit(ClothingItem item) {
    outfits.add(Outfit(items: [item], id: outfits.length + 1));
    notifyListeners();
  }

  void removeFromOutfit(int index, int itemIndex) {
    Outfit outfit = outfits.firstWhere((outfit) => outfit.id == index);
    outfit.items.removeAt(itemIndex);

    if (outfit.items.isEmpty) {
      outfits.removeWhere((outfit) => outfit.id == index);
      notifyListeners();
      return;
    }

    // replace the outfit with the updated outfit
    outfits = outfits.map((outfit) {
      if (outfit.id == index) {
        return outfit;
      }
      return outfit;
    }).toList();
    notifyListeners();
  }

  List<Outfit> getOutfits() {
    return outfits;
  }

  List<Outfit> getIncompleteOutfits(ClothingItem clothingitem) {
    return outfits
        .where((outfit) =>
            outfit.items.length < 2 &&
            outfit.items[0].type != ClothingType.dress &&
            outfit.items[0].type != clothingitem.type)
        .toList();
  }
}

final all_clothingitems = [];
