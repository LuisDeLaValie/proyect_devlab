import 'package:hive/hive.dart';

import '../github_models/repositorio_model.dart';


part 'proyecto_model.g.dart';

@HiveType(typeId: 0)
class ProyectoModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String nombre;
  @HiveField(2)
  final String creador;
  @HiveField(3)
  final String repositorio;
  @HiveField(4)
  final String path;
  @HiveField(5)
  final DateTime createAt;
  @HiveField(6)
  final RepositorioModel? repositorioMoel;

  ProyectoModel({
    required this.id,
    required this.nombre,
    required this.creador,
    required this.repositorio,
    required this.path,
    required this.createAt,
    this.repositorioMoel,
  });

  ProyectoModel copyWith({
    int? id,
    String? nombre,
    String? creador,
    String? repositorio,
    String? path,
    DateTime? createAt,
    RepositorioModel? repositorioMoel,
  }) {
    return ProyectoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      creador: creador ?? this.creador,
      repositorio: repositorio ?? this.repositorio,
      path: path ?? this.path,
      createAt: createAt ?? this.createAt,
      repositorioMoel: repositorioMoel ?? this.repositorioMoel,
    );
  }
}
