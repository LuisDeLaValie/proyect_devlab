// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssuesModelAdapter extends TypeAdapter<IssuesModel> {
  @override
  final int typeId = 2;

  @override
  IssuesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssuesModel(
      title: fields[0] as String,
      body: fields[1] as String,
      commentsUrl: fields[2] as String,
      creador: fields[3] as String,
      creadorUrl: fields[4] as String,
      creadorAvatarUrl: fields[5] as String,
      state: fields[6] as String,
      comments: fields[7] as int,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      labels: (fields[10] as List).cast<LabesIssuesModel?>(),
    );
  }

  @override
  void write(BinaryWriter writer, IssuesModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.commentsUrl)
      ..writeByte(3)
      ..write(obj.creador)
      ..writeByte(4)
      ..write(obj.creadorUrl)
      ..writeByte(5)
      ..write(obj.creadorAvatarUrl)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.comments)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.labels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssuesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LabesIssuesModelAdapter extends TypeAdapter<LabesIssuesModel> {
  @override
  final int typeId = 3;

  @override
  LabesIssuesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LabesIssuesModel(
      url: fields[0] as String,
      name: fields[1] as String,
      color: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LabesIssuesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabesIssuesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
