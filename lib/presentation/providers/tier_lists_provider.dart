import 'package:flutter/material.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/sources/popular_tier_lists.dart';
import 'package:tierlist/data/tier_list_repo.dart';

class TierListsProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<TierList> _userTierLists = [...PopularTierLists.popularTierLists];
  List<TierList> get userTierLists => _userTierLists;

  void deleteUserTierList(String id) {
    _userTierLists.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}

// class TierListsProvider with ChangeNotifier {
//   final TierListRepository _repository;
//   List<TierList> _userTierLists = [];
//   List<TierList> _popularTierLists = [];
//   bool _isLoading = false;

//   TierListsProvider(this._repository);

//   List<TierList> get userTierLists => _userTierLists;
//   List<TierList> get popularTierLists => _popularTierLists;
//   bool get isLoading => _isLoading;

//   Future<void> loadTierLists() async {
//     _isLoading = true;
//     notifyListeners();

//     _userTierLists = await _repository.getUserTierLists();
//     _popularTierLists = _repository.getPopularTierLists();

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> addUserTierList(TierList tierList) async {
//     await _repository.addUserTierList(tierList);
//     _userTierLists.add(tierList);
//     notifyListeners();
//   }

//   Future<void> addPopularTierList(TierList popularTierList) async {
//     await _repository.addPopularTierList(popularTierList);
//     await loadTierLists();
//   }

//   Future<void> updateTierList(TierList updatedTierList) async {
//     await _repository.updateTierList(updatedTierList);
//     final index = _userTierLists.indexWhere((t) => t.id == updatedTierList.id);
//     if (index != -1) {
//       _userTierLists[index] = updatedTierList;
//       notifyListeners();
//     }
//   }

//   Future<void> deleteUserTierList(String id) async {
//     await _repository.deleteUserTierList(id);
//     _userTierLists.removeWhere((t) => t.id == id);
//     notifyListeners();
//   }

//   Future<void> resetUserTierLists() async {
//     await _repository.resetUserTierLists();
//     _userTierLists.clear();
//     notifyListeners();
//   }
// }
