import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:tdtxle_inputs_flutter/inputs/img_perfil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/theme.dart';

class HeaderView extends StatelessWidget {
  HeaderView({Key? key}) : super(key: key);
  final List<FocusNode> _fosus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProyectoProvider>(builder: (context, pro, child) {
      return Container(
        color: colorD,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagenPerfil(
                  imgPath: pro.proyecto.img ?? "",
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/img/belzebuth.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          focusNode: _fosus[0],
                          pro.proyecto.nombre,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          iconSize: 20,
                          splashRadius: 1,
                          tooltip: "Ver repositorio",
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                  pro.proyecto.repositorioMoel?.htmlUrl ?? ""),
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          },
                          icon: Icon(
                              (pro.proyecto.repositorioMoel?.private ?? false)
                                  ? Icons.vpn_lock
                                  : Icons.public),
                        )
                      ],
                    ),
                    if (pro.proyecto.repositorio != null) ...[
                      SelectableText(
                          focusNode: _fosus[1], pro.proyecto.repositorio ?? ""),
                      Text(
                          "Lenguaje: ${pro.proyecto.repositorioMoel?.language ?? ""}"),
                    ]
                  ],
                ),
              ],
            ),
            if (pro.isGit) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SelectableText(focusNode: _fosus[2], "Branch: ${pro.branch}"),
                  const SizedBox(width: 10),
                  SelectableText(focusNode: _fosus[3], "Commit: ${pro.commit}"),
                ],
              ),
            ]
          ],
        ),
      );
    });
  }
}
