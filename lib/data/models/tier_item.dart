import 'package:hive/hive.dart';

abstract class TierListItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String? tier;

  TierListItem({required this.id, this.tier});
}
