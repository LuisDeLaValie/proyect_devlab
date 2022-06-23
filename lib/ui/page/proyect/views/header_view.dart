import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:tdtxle_fonts/tdtxle_fonts.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          iconSize: 30,
                          padding: const EdgeInsets.all(0.1),
                          splashRadius: 1,
                          tooltip: "Ver repositorio",
                          onPressed: () {
                            var url =
                                pro.proyecto.repositorioMoel?.htmlUrl ?? "";
                            launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          },
                          icon: const Icon(IconsTDTxLE.nf_dev_github_badge),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(IconsTDTxLE.nf_dev_git_branch),
                  SelectableText(focusNode: _fosus[2], "Branch: ${pro.branch}"),
                  const SizedBox(width: 10),
                  const Icon(IconsTDTxLE.nf_dev_git_commit),
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
