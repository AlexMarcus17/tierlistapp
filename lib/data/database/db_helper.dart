import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';

class DBHelper {
  static const String tierListBoxName = 'tierListBox';
  Box<TierList>? _tierListBox;

  DBHelper._();

  static Future<DBHelper> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TierListAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TierAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TierItemTextAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TierItemImageAdapter());
    }
    final dbHelper = DBHelper._();

    if (!Hive.isBoxOpen(tierListBoxName)) {
      dbHelper._tierListBox = await Hive.openBox<TierList>(tierListBoxName);
    } else {
      dbHelper._tierListBox = Hive.box<TierList>(tierListBoxName);
    }

    return dbHelper;
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
