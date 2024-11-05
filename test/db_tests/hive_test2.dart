import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/models/tier.dart';

void main() {
  setUp(() async {
    final testDir = '${Directory.current.path}/test/db_tests/hive_test_temp';
    Hive.init(testDir);

    Hive.registerAdapter(TierListAdapter());
    Hive.registerAdapter(TierAdapter());
  });

  test('Hive Test: Store and Retrieve TierList', () async {
    final box = await Hive.openBox<TierList>('tierLists');

    final tier1 = Tier(label: 'Tier A');
    final tier2 = Tier(label: 'Tier B');
    final tierList = TierList(
      id: '1',
      name: 'Example Tier List',
      tiers: [tier1, tier2],
      itemsMatrix: [[]],
      uncategorizedItems: [],
    );

    await box.put(tierList.id, tierList);

    final retrievedList = box.get(tierList.id) as TierList;

    expect(retrievedList.id, equals(tierList.id));
    expect(retrievedList.name, equals(tierList.name));
    expect(retrievedList.tiers.length, equals(tierList.tiers.length));
    expect(retrievedList.tiers[0].label, equals(tier1.label));
    expect(retrievedList.tiers[1].label, equals(tier2.label));

    await box.close();
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await Hive.close();
  });
}
