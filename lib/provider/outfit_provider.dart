import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class OutfitItem {
  final String imagePath;
  final String name;
  final String description;

  OutfitItem({
    required this.imagePath,
    required this.name,
    required this.description,
  });
}

class OutfitProvider extends ChangeNotifier {
  List<Tuple2<int, List<OutfitItem>>> outfits = [
    Tuple2(1, [
      OutfitItem(
          imagePath: 'assets/images/clothing/front1.jpeg',
          name: 'Clothing 1',
          description: 'Description 1'),
      OutfitItem(
          imagePath: 'assets/images/clothing/front17.jpeg',
          name: 'Clothing 17',
          description: 'Description 17')
    ]),
    Tuple2(2, [
      OutfitItem(
          imagePath: 'assets/images/clothing/front24.jpeg',
          name: 'Clothing 24',
          description: 'Description 24')
    ])
  ];

  void addToOutfit(int index, OutfitItem item) {
    if (outfits.any((outfit) => outfit.item1 == index)) {
      outfits = outfits.map((outfit) {
        if (outfit.item1 == index) {
          outfit.item2.add(item);
        }
        return outfit;
      }).toList();
    } else {
      outfits.add(Tuple2(index, [item]));
    }

    notifyListeners();
  }

  void createOutfit(OutfitItem item) {
    outfits.add(Tuple2(outfits.length + 1, [item]));
    notifyListeners();
  }

  void removeFromOutfit(int index, int itemIndex) {
    Tuple2<int, List<OutfitItem>> outfit =
        outfits.firstWhere((outfit) => outfit.item1 == index);
    outfit.item2.removeAt(itemIndex);

    if (outfit.item2.isEmpty) {
      outfits.removeWhere((outfit) => outfit.item1 == index);
      notifyListeners();
      return;
    }

    // replace the outfit with the updated outfit
    outfits = outfits.map((outfit) {
      if (outfit.item1 == index) {
        return outfit;
      }
      return outfit;
    }).toList();
    notifyListeners();
  }

  List<Tuple2<int, List<OutfitItem>>> getOutfits() {
    return outfits;
  }

  List<Tuple2<int, List<OutfitItem>>> getIncompleteOutfits() {
    return outfits.where((outfit) => outfit.item2.length < 2).toList();
  }
}
