import 'package:hive/hive.dart';

import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';

part 'tier_item_text.g.dart';

const int tierListItemTextTypeId = 2;

@HiveType(typeId: tierListItemTextTypeId)
class TierItemText extends TierListItem {
  @HiveField(2)
  final String text;

  TierItemText({
    required super.id,
    required super.tier,
    required this.text,
  });

  TierItemText copyWith({
    String? text,
    Tier? tier,
  }) {
    return TierItemText(
      id: id,
      tier: tier ?? this.tier,
      text: text ?? this.text,
    );
  }
}
