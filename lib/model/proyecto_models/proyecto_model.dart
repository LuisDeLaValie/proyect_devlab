import 'package:hive/hive.dart';

import '../github_models/repositorio_model.dart';

part 'proyecto_model.g.dart';

@HiveType(typeId: 0)
class ProyectoModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  String creador;
  @HiveField(3)
  String repositorio;
  @HiveField(4)
  String path;
  @HiveField(5)
  DateTime createAt;
  @HiveField(6)
  RepositorioModel? repositorioMoel;

  ProyectoModel({
    required this.id,
    required this.nombre,
    required this.creador,
    required this.repositorio,
    required this.path,
    required this.createAt,
    this.repositorioMoel,
  });

 
}
