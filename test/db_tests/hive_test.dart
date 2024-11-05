import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item_text.dart';

void main() {
  setUp(() async {
    final testDir = '${Directory.current.path}/test/db_tests/hive_test_temp';
    Hive.init(testDir);

    Hive.registerAdapter(TierItemTextAdapter());
    Hive.registerAdapter(TierAdapter());
  });

  test('Hive Test: Store and Retrieve TierItemText', () async {
    final box = await Hive.openBox<TierItemText>('tierItems');

    final tierItem =
        TierItemText(id: '1', tier: Tier(label: 'A'), text: 'Example Text');

    await box.put(tierItem.id, tierItem);

    final retrievedItem = box.get(tierItem.id) as TierItemText;

    expect(retrievedItem.id, equals(tierItem.id));
    expect(retrievedItem.tier, equals(tierItem.tier));
    expect(retrievedItem.text, equals(tierItem.text));

    await box.close();
  });

  tearDown(() async {
    await Hive.close();
  });
}
