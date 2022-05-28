import 'package:flutter/material.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderView extends StatelessWidget {
  final ProyectoModel proyecto;

  const HeaderView({
    Key? key,
    required this.proyecto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(proyecto.nombre,
                style: Theme.of(context).textTheme.headlineMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            proyecto.repositorioMoel?.creadorUrl ?? ""));
                      },
                      child: Text(proyecto.creador),
                    ),
                    Text(
                        "Lenguaje: ${proyecto.repositorioMoel?.language ?? ""}"),
                  ],
                ),
                IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    launchUrl(Uri.parse(proyecto.repositorio));
                  },
                  icon: Icon((proyecto.repositorioMoel?.private ?? false)
                      ? Icons.vpn_lock
                      : Icons.public),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
