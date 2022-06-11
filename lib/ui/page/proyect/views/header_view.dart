import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:tdtxle_inputs_flutter/inputs/img_perfil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/theme.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProyectoProvider>(builder: (context, pro, child) {
      return Container(
        color: colorD,
        padding: const EdgeInsets.all(20),
        child: Row(
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
                SelectableText(pro.proyecto.nombre,
                    style: Theme.of(context).textTheme.headlineSmall),
                if (pro.proyecto.repositorio != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              var url =
                                  pro.proyecto.repositorioMoel?.creadorUrl ??
                                      "";
                              launchUrl(Uri.parse(url));
                            },
                            child: Text(pro.proyecto.creador),
                          ),
                          Text(
                              "Lenguaje: ${pro.proyecto.repositorioMoel?.language ?? ""}"),
                        ],
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          launchUrl(Uri.parse(pro.proyecto.repositorio!));
                        },
                        icon: Icon(
                            (pro.proyecto.repositorioMoel?.private ?? false)
                                ? Icons.vpn_lock
                                : Icons.public),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
