import 'package:hive/hive.dart';

part 'perfiles_model.g.dart';

@HiveType(typeId: 3)
class PerfilesModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  DateTime creado;

  PerfilesModel({
    required this.id,
    required this.nombre,
    required this.creado,
  });
}
