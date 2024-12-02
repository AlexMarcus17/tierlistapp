// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TierListAdapter extends TypeAdapter<TierList> {
  @override
  final int typeId = 0;

  @override
  TierList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TierList(
      id: fields[0] as String,
      name: fields[1] as String,
      tiers: (fields[2] as List).cast<Tier>(),
      itemsMatrix: (fields[3] as List)
          .map((dynamic e) => (e as List).cast<TierListItem>())
          .toList(),
      uncategorizedItems: (fields[4] as List).cast<TierListItem>(),
      imagePath: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TierList obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tiers)
      ..writeByte(3)
      ..write(obj.itemsMatrix)
      ..writeByte(4)
      ..write(obj.uncategorizedItems)
      ..writeByte(5)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TierListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
