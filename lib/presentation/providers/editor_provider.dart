import 'dart:io';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';

@injectable
class EditorProvider with ChangeNotifier {
  TierList _tierList;

  EditorProvider(@factoryParam TierList? existingTierList)
      : _tierList = existingTierList ??
            TierList(
              imagePath: "lib/assets/images/tierlistcard.png",
              id: DateTime.now().toIso8601String(),
              name: 'New Tier List',
              tiers: [
                Tier(label: 'S'),
                Tier(label: 'A'),
                Tier(label: 'B'),
                Tier(label: 'C'),
                Tier(label: 'D')
              ],
              itemsMatrix: [[], [], [], [], []],
              uncategorizedItems: [],
            );

  TierList get tierList => _tierList;

  void changeTierListName(String newName) {
    _tierList = _tierList.copyWith(name: newName);
    notifyListeners();
  }

  void addNewTextItem(String text) {
    final newItem = TierItemText(
        id: DateTime.now().toIso8601String(),
        tier: Tier(label: null),
        text: text);
    _tierList.uncategorizedItems.add(newItem);
    notifyListeners();
  }

  void changeItemTextById(String id, String newText) {
    for (int i = 0; i < _tierList.uncategorizedItems.length; i++) {
      if (_tierList.uncategorizedItems[i] is TierItemText &&
          _tierList.uncategorizedItems[i].id == id) {
        _tierList.uncategorizedItems[i] =
            (_tierList.uncategorizedItems[i] as TierItemText)
                .copyWith(text: newText);
        notifyListeners();
        return;
      }
    }

    for (int tierIndex = 0;
        tierIndex < _tierList.itemsMatrix.length;
        tierIndex++) {
      for (int itemIndex = 0;
          itemIndex < _tierList.itemsMatrix[tierIndex].length;
          itemIndex++) {
        final item = _tierList.itemsMatrix[tierIndex][itemIndex];
        if (item is TierItemText && item.id == id) {
          _tierList.itemsMatrix[tierIndex][itemIndex] =
              item.copyWith(text: newText);
          notifyListeners();
          return;
        }
      }
    }
  }

  void deleteItemById(String id) {
    _tierList.uncategorizedItems.removeWhere((item) => item.id == id);

    for (int tierIndex = 0;
        tierIndex < _tierList.itemsMatrix.length;
        tierIndex++) {
      _tierList.itemsMatrix[tierIndex].removeWhere((item) => item.id == id);
    }

    notifyListeners();
  }

  void addNewImageItem(File imageFile) {
    final newItem = TierItemImage(
        id: DateTime.now().toIso8601String(),
        tier: Tier(label: null),
        imageFile: imageFile);
    _tierList.uncategorizedItems.add(newItem);
    notifyListeners();
  }

  void changeTiers(List<String> newTierLabels) {
    List<Tier> updatedTiers = List.generate(5, (index) {
      return _tierList.tiers[index].copyWith(label: newTierLabels[index]);
    });

    List<List<TierListItem>> updatedItemMatrix =
        _tierList.itemsMatrix.map((row) {
      return row.map((item) {
        if (item is TierItemText) {
          return item.copyWith(
              tier: updatedTiers[_tierList.tiers.indexOf(item.tier)]);
        } else if (item is TierItemImage) {
          return item.copyWith(
              tier: updatedTiers[_tierList.tiers.indexOf(item.tier)]);
        }
        return item;
      }).toList();
    }).toList();

    _tierList = _tierList.copyWith(
      tiers: updatedTiers,
      itemsMatrix: updatedItemMatrix,
    );

    notifyListeners();
  }

  void changeItemPlace(TierListItem item, int? newTierIndex, int newIndex) {
    final oldTierIndex =
        _tierList.tiers.indexWhere((tier) => tier == item.tier);

    if (oldTierIndex >= 0) {
      _tierList.itemsMatrix[oldTierIndex].removeWhere((i) => i.id == item.id);
    } else {
      _tierList.uncategorizedItems.removeWhere((i) => i.id == item.id);
    }

    if (newTierIndex != null && newTierIndex < _tierList.tiers.length) {
      item.tier = _tierList.tiers[newTierIndex];
      _tierList.itemsMatrix[newTierIndex].insert(newIndex, item);
    } else if (newTierIndex == null) {
      item.tier = Tier(label: null);
      _tierList.uncategorizedItems.insert(newIndex, item);
    }

    notifyListeners();
  }

  bool hasReachedMaxItems() {
    final int totalItems = _tierList.uncategorizedItems.length +
        _tierList.itemsMatrix
            .fold(0, (sum, tierItems) => sum + tierItems.length);

    return totalItems >= 50;
  }

  void save(Function(TierList) saveCallback) {
    saveCallback(_tierList);
    notifyListeners();
  }
}
