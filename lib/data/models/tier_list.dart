import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';

part 'tier_list.g.dart';

const int tierListTypeId = 0;

@HiveType(typeId: tierListTypeId)
class TierList {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<Tier> tiers;
  @HiveField(3)
  final List<List<TierListItem>> itemsMatrix;
  @HiveField(4)
  final List<TierListItem> uncategorizedItems;

  TierList({
    required this.id,
    required this.name,
    required this.tiers,
    required this.itemsMatrix,
    required this.uncategorizedItems,
  });
}
