import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier_list.dart';

class DBHelper {
  static const String tierListBoxName = 'tierListBox';
  Box<TierList>? _tierListBox;

  Future<void> init() async {
    if (!Hive.isBoxOpen(tierListBoxName)) {
      _tierListBox = await Hive.openBox<TierList>(tierListBoxName);
    } else {
      _tierListBox = Hive.box<TierList>(tierListBoxName);
    }
  }

  Future<void> addTierList(TierList tierList) async {
    await _tierListBox?.put(tierList.id, tierList);
  }

  Future<void> updateTierList(TierList tierList) async {
    if (_tierListBox?.containsKey(tierList.id) == true) {
      await _tierListBox?.put(tierList.id, tierList);
    } else {
      throw Exception('TierList with id ${tierList.id} does not exist.');
    }
  }

  Future<void> deleteTierList(String id) async {
    if (_tierListBox?.containsKey(id) == true) {
      await _tierListBox?.delete(id);
    } else {
      throw Exception('TierList with id $id does not exist.');
    }
  }

  Future<TierList?> getTierList(String id) async {
    return _tierListBox?.get(id);
  }

  Future<List<TierList>> getAllTierLists() async {
    return _tierListBox?.values.toList().cast<TierList>() ?? [];
  }

  Future<void> resetUserTierLists() async {
    await _tierListBox?.clear();
  }
}
