import 'package:flutter/material.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'package:proyect_devlab/model/github_models/repositorio_model.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';

class ItemsCards extends StatelessWidget {
  final RepositorioModel repo;
  const ItemsCards({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          var proyecto = ProyectoModel(
            id: 0,
            nombre: repo.name,
            creador: repo.creador,
            repositorio: repo.htmlUrl,
            path: '',
            createAt: repo.createdAt,
            repositorioMoel: repo,
          );
          NavegacionServies.navigateTo(proyectoRoute, arguments: proyecto);
        },
        child: Material(
          elevation: 2,
          child: Column(
            children: [
              Text(repo.visibility,
                  style: Theme.of(context).textTheme.bodyMedium),
              Spacer(),
              Text(repo.name, style: Theme.of(context).textTheme.bodyLarge),
              Text(repo.language,
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
