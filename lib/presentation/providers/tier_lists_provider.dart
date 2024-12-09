import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/tier_list_repo.dart';

@singleton
class TierListsProvider with ChangeNotifier {
  final TierListRepository _repository;
  List<TierList> _userTierLists = [];
  List<TierList> _popularTierLists = [];
  bool _isLoading = true;

  TierListsProvider(this._repository) {
    loadTierLists();
  }

  List<TierList> get userTierLists => _userTierLists;
  List<TierList> get popularTierLists => _popularTierLists;
  bool get isLoading => _isLoading;

  Future<void> loadTierLists() async {
    _userTierLists = await _repository.getUserTierLists();
    _popularTierLists = _repository.getPopularTierLists();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addUserTierList(TierList tierList) async {
    _userTierLists.add(tierList);
    notifyListeners();
    await _repository.addUserTierList(tierList);
  }

  Future<void> renameTierList(String id, String newName) async {
    final index = _userTierLists.indexWhere((t) => t.id == id);
    if (index != -1) {
      _userTierLists[index] = _userTierLists[index].copyWith(name: newName);
      notifyListeners();
    }
    await _repository.renameTierList(id, newName);
  }

  Future<bool> addPopularTierList(TierList popularTierList) async {
    if (_userTierLists.any((t) => t.id == popularTierList.id)) {
      return false;
    } else {
      _userTierLists.add(popularTierList);
      notifyListeners();
      await _repository.addUserTierList(popularTierList);
      return true;
    }
  }

  Future<void> updateTierList(TierList updatedTierList) async {
    final index = _userTierLists.indexWhere((t) => t.id == updatedTierList.id);
    if (index != -1) {
      _userTierLists[index] = updatedTierList;
      notifyListeners();
    }
    await _repository.updateTierList(updatedTierList);
  }

  Future<void> deleteUserTierList(String id) async {
    _userTierLists.removeWhere((t) => t.id == id);
    notifyListeners();
    await _repository.deleteUserTierList(id);
  }

  Future<void> resetUserTierLists() async {
    await _repository.resetUserTierLists();
    _userTierLists.clear();
    notifyListeners();
  }
}
