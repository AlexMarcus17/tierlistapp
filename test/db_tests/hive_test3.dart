import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/database/db_helper.dart';

void main() {
  late DBHelper dbHelper;

  setUp(() async {
    final testDir = '${Directory.current.path}/test/db_tests/hive_test_temp';
    Hive.init(testDir);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TierListAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TierAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TierItemTextAdapter());
    }

    dbHelper = DBHelper();
    await dbHelper.init();
  });

  test('DBHelper Test: Add and Retrieve TierList', () async {
    final tier1 = Tier(label: 'Tier A');
    final tier2 = Tier(label: 'Tier B');

    final tierItem1 =
        TierItemText(id: 'item1', tier: Tier(label: "A"), text: 'Item 1 Text');
    final tierItem2 =
        TierItemText(id: 'item2', tier: Tier(label: "B"), text: 'Item 2 Text');

    final tierList = TierList(
      id: '1',
      name: 'Example Tier List',
      tiers: [tier1, tier2],
      itemsMatrix: [
        [tierItem1],
        [tierItem2]
      ],
      uncategorizedItems: [tierItem1, tierItem2],
    );

    await dbHelper.addTierList(tierList);
    final retrievedList = await dbHelper.getTierList(tierList.id);

    expect(retrievedList, isNotNull);
    expect(retrievedList!.id, equals(tierList.id));
    expect(retrievedList.name, equals(tierList.name));
    expect(retrievedList.tiers.length, equals(tierList.tiers.length));
  });

  test('DBHelper Test: Update TierList', () async {
    final tier1 = Tier(label: 'Tier A');
    final tierItem1 =
        TierItemText(id: 'item1', tier: Tier(label: "A"), text: 'Item 1 Text');

    final tierList = TierList(
      id: '2',
      name: 'Old Tier List',
      tiers: [tier1],
      itemsMatrix: [
        [tierItem1],
      ],
      uncategorizedItems: [],
    );

    await dbHelper.addTierList(tierList);

    final updatedTierList = TierList(
      id: '2',
      name: 'Updated Tier List',
      tiers: [tier1],
      itemsMatrix: [
        [tierItem1],
      ],
      uncategorizedItems: [],
    );

    await dbHelper.updateTierList(updatedTierList);
    final retrievedList = await dbHelper.getTierList(updatedTierList.id);

    expect(retrievedList!.name, equals(updatedTierList.name));
  });

  test('DBHelper Test: Delete TierList', () async {
    final tier1 = Tier(label: 'Tier A');
    final tierItem1 =
        TierItemText(id: 'item1', tier: Tier(label: "A"), text: 'Item 1 Text');

    final tierList = TierList(
      id: '3',
      name: 'Delete Test Tier List',
      tiers: [tier1],
      itemsMatrix: [
        [tierItem1],
      ],
      uncategorizedItems: [],
    );

    await dbHelper.addTierList(tierList);
    await dbHelper.deleteTierList(tierList.id);

    final retrievedList = await dbHelper.getTierList(tierList.id);
    expect(retrievedList, isNull);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await Hive.close();
  });
}
