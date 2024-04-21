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

final all_clothingitems = [
  ClothingItem(
      id: 1,
      imagePath: 'assets/images/clothing/front1.jpeg',
      name: 'Clothing 1',
      description: 'Description 1',
      type: ClothingType.top),
  ClothingItem(
      id: 2,
      imagePath: 'assets/images/clothing/front2.jpeg',
      name: 'Clothing 2',
      description: 'Description 2',
      type: ClothingType.top),
  ClothingItem(
      id: 3,
      imagePath: 'assets/images/clothing/front3.jpeg',
      name: 'Clothing 3',
      description: 'Description 3',
      type: ClothingType.top),
  ClothingItem(
      id: 4,
      imagePath: 'assets/images/clothing/front4.jpeg',
      name: 'Clothing 4',
      description: 'Description 4',
      type: ClothingType.top),
  ClothingItem(
      id: 5,
      imagePath: 'assets/images/clothing/front5.jpeg',
      name: 'Clothing 5',
      description: 'Description 5',
      type: ClothingType.top),
  ClothingItem(
      id: 6,
      imagePath: 'assets/images/clothing/front6.jpeg',
      name: 'Clothing 6',
      description: 'Description 6',
      type: ClothingType.bottom),
  ClothingItem(
      id: 7,
      imagePath: 'assets/images/clothing/front7.jpeg',
      name: 'Clothing 7',
      description: 'Description 7',
      type: ClothingType.bottom),
  ClothingItem(
      id: 8,
      imagePath: 'assets/images/clothing/front8.jpeg',
      name: 'Clothing 8',
      description: 'Description 8',
      type: ClothingType.bottom),
  ClothingItem(
      id: 9,
      imagePath: 'assets/images/clothing/front9.jpeg',
      name: 'Clothing 9',
      description: 'Description 9',
      type: ClothingType.bottom),
  ClothingItem(
      id: 10,
      imagePath: 'assets/images/clothing/front10.jpeg',
      name: 'Clothing 10',
      description: 'Description 10',
      type: ClothingType.bottom),
  ClothingItem(
      id: 11,
      imagePath: 'assets/images/clothing/front11.jpeg',
      name: 'Clothing 11',
      description: 'Description 11',
      type: ClothingType.bottom),
  ClothingItem(
      id: 12,
      imagePath: 'assets/images/clothing/front12.jpeg',
      name: 'Clothing 12',
      description: 'Description 12',
      type: ClothingType.bottom),
  ClothingItem(
      id: 13,
      imagePath: 'assets/images/clothing/front13.jpeg',
      name: 'Clothing 13',
      description: 'Description 13',
      type: ClothingType.top),
  ClothingItem(
      id: 14,
      imagePath: 'assets/images/clothing/front14.jpeg',
      name: 'Clothing 14',
      description: 'Description 14',
      type: ClothingType.top),
  ClothingItem(
      id: 15,
      imagePath: 'assets/images/clothing/front15.jpeg',
      name: 'Clothing 15',
      description: 'Description 15',
      type: ClothingType.top),
  ClothingItem(
      id: 16,
      imagePath: 'assets/images/clothing/front16.jpeg',
      name: 'Clothing 16',
      description: 'Description 16',
      type: ClothingType.top),
  ClothingItem(
      id: 17,
      imagePath: 'assets/images/clothing/front17.jpeg',
      name: 'Clothing 17',
      description: 'Description 17',
      type: ClothingType.bottom),
  ClothingItem(
      id: 18,
      imagePath: 'assets/images/clothing/front18.jpeg',
      name: 'Clothing 18',
      description: 'Description 18',
      type: ClothingType.bottom),
  ClothingItem(
      id: 19,
      imagePath: 'assets/images/clothing/front19.jpeg',
      name: 'Clothing 19',
      description: 'Description 19',
      type: ClothingType.bottom),
  ClothingItem(
      id: 20,
      imagePath: 'assets/images/clothing/front20.jpeg',
      name: 'Clothing 20',
      description: 'Description 20',
      type: ClothingType.bottom),
  ClothingItem(
      id: 21,
      imagePath: 'assets/images/clothing/front21.jpeg',
      name: 'Clothing 21',
      description: 'Description 21',
      type: ClothingType.top),
  ClothingItem(
      id: 22,
      imagePath: 'assets/images/clothing/front22.jpeg',
      name: 'Clothing 22',
      description: 'Description 22',
      type: ClothingType.top),
  ClothingItem(
      id: 23,
      imagePath: 'assets/images/clothing/front23.jpeg',
      name: 'Clothing 23',
      description: 'Description 23',
      type: ClothingType.dress),
  ClothingItem(
      id: 24,
      imagePath: 'assets/images/clothing/front24.jpeg',
      name: 'Clothing 24',
      description: 'Description 24',
      type: ClothingType.dress),
];
