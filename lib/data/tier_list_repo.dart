import 'package:tierlist/data/database/db_helper.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/sources/popular_tier_lists.dart';

class TierListRepository {
  static final TierListRepository _instance = TierListRepository._internal();
  factory TierListRepository() => _instance;

  TierListRepository._internal();

  final DBHelper _dbHelper = DBHelper();

  final List<TierList> _popularTierLists = PopularTierLists.popularTierLists;

  Future<void> init() async {
    await _dbHelper.init();
  }

  Future<List<TierList>> getUserTierLists() async {
    return await _dbHelper.getAllTierLists();
  }

  List<TierList> getPopularTierLists() {
    return _popularTierLists;
  }

  Future<void> addUserTierList(TierList tierList) async {
    await _dbHelper.addTierList(tierList);
  }

  Future<void> addPopularTierList(TierList popularTierList) async {
    final userTierList = TierList(
      id: DateTime.now().toIso8601String(),
      name: popularTierList.name,
      tiers: popularTierList.tiers,
      itemsMatrix: popularTierList.itemsMatrix,
      uncategorizedItems: popularTierList.uncategorizedItems,
    );
    await addUserTierList(userTierList);
  }

  Future<void> updateTierList(TierList updatedTierList) async {
    await _dbHelper.updateTierList(updatedTierList);
  }

  Future<void> deleteUserTierList(String id) async {
    await _dbHelper.deleteTierList(id);
  }

  Future<void> resetUserTierLists() async {
    await _dbHelper.resetUserTierLists();
  }
}
