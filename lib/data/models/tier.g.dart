// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TierAdapter extends TypeAdapter<Tier> {
  @override
  final int typeId = 1;

  @override
  Tier read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tier(
      label: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tier obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
