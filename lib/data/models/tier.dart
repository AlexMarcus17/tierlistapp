// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'tier.g.dart';

const int tierTypeId = 1;

@HiveType(typeId: tierTypeId)
class Tier {
  @HiveField(0)
  final String? label;

  Tier({required this.label});

  Tier copyWith({
    String? label,
  }) {
    return Tier(
      label: label ?? this.label,
    );
  }
}
