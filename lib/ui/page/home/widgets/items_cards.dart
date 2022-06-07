import 'package:flutter/material.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'package:proyect_devlab/services/navegacion_servies.dart';

class ItemsCards extends StatelessWidget {
  final ProyectoModel repo;
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
          NavegacionServies.navigateTo(
              proyectoRoute.replaceAll(":id", "${repo.id}"));
        },
        child: Material(
          elevation: 2,
          child: Column(
            children: [
              const Spacer(),
              Text(repo.nombre, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
