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
  bool _viewTiers = false;
  bool _viewInfo = false;

  EditorProvider(@factoryParam TierList? existingTierList)
      : _tierList = existingTierList ??
            TierList(
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
  bool get viewTiers => _viewTiers;
  bool get viewInfo => _viewInfo;

  void changeTierListName(String newName) {
    _tierList = _tierList.copyWith(name: newName);
    notifyListeners();
  }

  void addNewTextItem(String text) {
    final newItem = TierItemText(
        id: DateTime.now().toIso8601String(),
        tier: _tierList.tiers.first,
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

  void setViewTiers() {
    _viewTiers = true;
    notifyListeners();
  }

  void setViewItems() {
    _viewTiers = false;
    _viewInfo = false;
    notifyListeners();
  }

  void setViewInfo() {
    _viewInfo = true;
    notifyListeners();
  }

  void addNewTier(String label) {
    final newTier = Tier(label: label);
    _tierList.tiers.add(newTier);
    _tierList.itemsMatrix.add([]);
    notifyListeners();
  }

  void changeTierName(int tierIndex, String newLabel) {
    if (tierIndex < _tierList.tiers.length && newLabel.isNotEmpty) {
      _tierList.tiers[tierIndex] =
          _tierList.tiers[tierIndex].copyWith(label: newLabel);
      notifyListeners();
    }
  }

  void removeTier(int tierIndex) {
    if (tierIndex < _tierList.tiers.length && _tierList.tiers.length > 1) {
      _tierList.tiers.removeAt(tierIndex);
      _tierList.itemsMatrix.removeAt(tierIndex);
      notifyListeners();
    } else {
      throw Exception('Cannot remove the last tier.');
    }
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
      item.tier = _tierList.tiers.first;
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

  void share() {
    // Functionality to be implemented later
  }
}
