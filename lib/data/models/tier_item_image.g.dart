// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier_item_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TierItemImageAdapter extends TypeAdapter<TierItemImage> {
  @override
  final int typeId = 3;

  @override
  TierItemImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TierItemImage(
      id: fields[0] as String,
      tier: fields[1] as Tier,
      imageFile: fields[2] as File,
    );
  }

  @override
  void write(BinaryWriter writer, TierItemImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.imageFile)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TierItemImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
