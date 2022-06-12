import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:tdtxle_inputs_flutter/inputs/img_perfil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/git_servicis.dart';
import '../../../shared/theme.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  bool isgit = false;
  String? commit = "";
  String? branch = "";
  final List<FocusNode> _fosus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  @override
  void initState() {
    var path = context.read<ProyectoProvider>().proyecto.path;
    GitServices().isRepo("$path/proyecto").then((value) async {
      if (value) {
        getGitData("$path/proyecto");
      }
    });

    super.initState();
  }

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
            if (isgit) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SelectableText(focusNode: _fosus[2], "Branch: $branch"),
                  const SizedBox(width: 10),
                  SelectableText(focusNode: _fosus[3], "Commit: $commit"),
                ],
              ),
            ]
          ],
        ),
      );
    });
  }

  void getGitData(String directory) async {
    try {

      var pro = context.read<ProyectoProvider>();
      var git = GitServices();

      var branchs = await git.getBranch(directory);
      var commits = await git.getCommits(directory);
      commit = await git.getCommit(directory);

      branch = branchs!.firstWhere((element) => element.contains("*"));
      branch = branch!.replaceAll("* ", "");
      
      isgit = true;
      pro.branchs = branchs;
      pro.commits = commits;
      pro.commit = commit;
      pro.isGit = true;

    } catch (e) {
      log(e.toString(), name: "HeaderView");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
