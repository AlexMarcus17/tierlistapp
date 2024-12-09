import 'package:injectable/injectable.dart';
import 'package:tierlist/data/database/db_helper.dart';
import 'package:tierlist/data/models/tier_list.dart';

@singleton
class TierListRepository {
  final DBHelper _dbHelper;
  final List<TierList> _popularTierLists;

  TierListRepository(this._dbHelper, this._popularTierLists);

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
      imagePath: "lib/assets/images/tierlistcard.png",
    );
    await addUserTierList(userTierList);
  }

  Future<void> updateTierList(TierList updatedTierList) async {
    await _dbHelper.updateTierList(updatedTierList);
  }

  Future<void> renameTierList(String id, String newName) async {
    final tierList = await _dbHelper.getTierList(id);
    if (tierList != null) {
      await _dbHelper.updateTierList(tierList.copyWith(name: newName));
    }
  }

  Future<void> deleteUserTierList(String id) async {
    await _dbHelper.deleteTierList(id);
  }

  Future<void> resetUserTierLists() async {
    await _dbHelper.resetUserTierLists();
  }
}
