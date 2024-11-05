import 'package:hive/hive.dart';

part 'tier.g.dart';

const int tierTypeId = 1;

@HiveType(typeId: tierTypeId)
class Tier {
  @HiveField(0)
  final String label;

  Tier({required this.label});
}
