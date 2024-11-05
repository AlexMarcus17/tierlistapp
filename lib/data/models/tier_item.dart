import 'package:hive/hive.dart';
import 'package:tierlist/data/models/tier.dart';

abstract class TierListItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  Tier tier;

  TierListItem({required this.id, required this.tier});
}
