import 'package:hive/hive.dart';

import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';

part 'tier_item_image.g.dart';

const int tierListItemImageTypeId = 3;

@HiveType(typeId: tierListItemImageTypeId)
class TierItemImage extends TierListItem {
  @HiveField(2)
  final String imageFile;

  TierItemImage({
    required super.id,
    required super.tier,
    required this.imageFile,
  });

  TierItemImage copyWith({
    String? imageFile,
    Tier? tier,
  }) {
    return TierItemImage(
      imageFile: imageFile ?? this.imageFile,
      id: id,
      tier: tier ?? this.tier,
    );
  }
}
