import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier_item.dart';

part 'tier_item_text.g.dart';

const int tierListItemTextTypeId = 2;

@HiveType(typeId: tierListItemTextTypeId)
class TierItemText extends TierListItem {
  @HiveField(2)
  final String text;

  TierItemText({
    required super.id,
    super.tier,
    required this.text,
  });
}
