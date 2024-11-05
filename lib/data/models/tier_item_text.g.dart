// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier_item_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TierItemTextAdapter extends TypeAdapter<TierItemText> {
  @override
  final int typeId = 2;

  @override
  TierItemText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TierItemText(
      id: fields[0] as String,
      tier: fields[1] as Tier,
      text: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TierItemText obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.text)
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
      other is TierItemTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
