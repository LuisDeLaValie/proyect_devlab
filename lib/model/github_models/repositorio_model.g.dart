// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repositorio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepositorioModelAdapter extends TypeAdapter<RepositorioModel> {
  @override
  final int typeId = 1;

  @override
  RepositorioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepositorioModel(
      id: fields[0] as int,
      nodeId: fields[1] as String,
      name: fields[2] as String,
      fullName: fields[3] as String,
      private: fields[4] as bool,
      htmlUrl: fields[5] as String,
      description: fields[6] as String?,
      url: fields[7] as String,
      branchesUrl: fields[8] as String,
      tagsUrl: fields[9] as String,
      languagesUrl: fields[10] as String,
      commitsUrl: fields[11] as String,
      archiveUrl: fields[12] as String,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      pushedAt: fields[15] as DateTime,
      gitUrl: fields[16] as String,
      sshUrl: fields[17] as String,
      cloneUrl: fields[18] as String,
      svnUrl: fields[19] as String,
      homepage: fields[20] as String?,
      language: fields[21] as String,
      visibility: fields[22] as String,
      creador: fields[23] as String,
      creadorUrl: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RepositorioModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nodeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.private)
      ..writeByte(5)
      ..write(obj.htmlUrl)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.branchesUrl)
      ..writeByte(9)
      ..write(obj.tagsUrl)
      ..writeByte(10)
      ..write(obj.languagesUrl)
      ..writeByte(11)
      ..write(obj.commitsUrl)
      ..writeByte(12)
      ..write(obj.archiveUrl)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.pushedAt)
      ..writeByte(16)
      ..write(obj.gitUrl)
      ..writeByte(17)
      ..write(obj.sshUrl)
      ..writeByte(18)
      ..write(obj.cloneUrl)
      ..writeByte(19)
      ..write(obj.svnUrl)
      ..writeByte(20)
      ..write(obj.homepage)
      ..writeByte(21)
      ..write(obj.language)
      ..writeByte(22)
      ..write(obj.visibility)
      ..writeByte(23)
      ..write(obj.creador)
      ..writeByte(25)
      ..write(obj.creadorUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositorioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
