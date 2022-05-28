// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proyecto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProyectoModelAdapter extends TypeAdapter<ProyectoModel> {
  @override
  final int typeId = 0;

  @override
  ProyectoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProyectoModel(
      id: fields[0] as int,
      nombre: fields[1] as String,
      creador: fields[2] as String,
      repositorio: fields[3] as String,
      path: fields[4] as String,
      createAt: fields[5] as DateTime,
      repositorioMoel: fields[6] as RepositorioModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ProyectoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.creador)
      ..writeByte(3)
      ..write(obj.repositorio)
      ..writeByte(4)
      ..write(obj.path)
      ..writeByte(5)
      ..write(obj.createAt)
      ..writeByte(6)
      ..write(obj.repositorioMoel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProyectoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
