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
          child: Stack(
            children: [
              Image.asset("assets/img/belzebuth.png"),
              Column(
                children: [
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      repo.nombre,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
