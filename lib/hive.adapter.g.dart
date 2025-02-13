// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPasswordAdapter extends TypeAdapter<SavedPassword> {
  @override
  final int typeId = 0;

  @override
  SavedPassword read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPassword(
      name: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPassword obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
