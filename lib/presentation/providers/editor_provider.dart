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
              itemsMatrix: [[]],
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

  void addNewImageItem(File imageFile) {
    final newItem = TierItemImage(
        id: DateTime.now().toIso8601String(),
        tier: _tierList.tiers.first,
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
      _tierList.itemsMatrix[oldTierIndex].remove(item);
    } else {
      _tierList.uncategorizedItems.remove(item);
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

  void deleteTierItem(TierListItem item) {
    final tierIndex = _tierList.tiers.indexWhere((tier) => tier == item.tier);
    if (tierIndex >= 0) {
      _tierList.itemsMatrix[tierIndex].remove(item);
    } else {
      _tierList.uncategorizedItems.remove(item);
    }
    notifyListeners();
  }

  void save(Function(TierList) saveCallback) {
    saveCallback(_tierList);
    notifyListeners();
  }

  void download() {
    // Functionality to be implemented later
  }
}
