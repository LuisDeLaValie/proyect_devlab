// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfiles_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PerfilesModelAdapter extends TypeAdapter<PerfilesModel> {
  @override
  final int typeId = 3;

  @override
  PerfilesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PerfilesModel(
      id: fields[0] as String,
      nombre: fields[1] as String,
      creado: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PerfilesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.creado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerfilesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
