import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';

import '../../../provider/proyecto_provider.dart';
import '../../../services/git_servicis.dart';
import 'views/curpo_general_view.dart';
import 'views/header_view.dart';

class ProyectPage extends StatefulWidget {
  const ProyectPage({Key? key}) : super(key: key);

  @override
  State<ProyectPage> createState() => _ProyectPageState();
}

class _ProyectPageState extends State<ProyectPage> {
  @override
  void initState() {
    super.initState();
    cargainical();
  }

  @override
  Widget build(BuildContext context) {
    return HomeDesktopLayout(
      body: Column(
        children:  [
          HeaderView(),
          const SizedBox(height: 5),
          const Expanded(child: CurpoGeneralView())
        ],
      ),
    );
  }

  void cargainical() async {
    var pro = context.read<ProyectoProvider>();
    var path = pro.proyecto.path;

    bool isrepo = false;
    List<String>? branchs;
    String? branch;
    List<String>? commits;
    String? commit;

    ///
    /// CArgar los archivos
    ///
    pro.getTree().catchError((error) {
      log(error.toString(), name: "Error Traer Archivo");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    });

    ///
    ///saber si el proyecto usa git
    ///

    isrepo = await GitServices().isRepo("$path/proyecto").catchError((error) {
      log(error.toString(), name: "Error es repo");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    });
    pro.isGit = isrepo;

    ///
    /// Bloque que trar la info del repositorio en caso de que lo sea
    ///
    if (isrepo) {
      var git = GitServices();

      ///
      /// Trar las ramas del repositorio
      ///
      branchs = await git.getBranch("$path/proyecto").catchError((error) {
        log(error.toString(), name: "Error traer branch");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      });
      branch = branchs!.firstWhere((element) => element.contains("*"));
      branch = branch.replaceAll("* ", "");
      pro.branch = branch;
      pro.branchs = branchs;

      ///
      /// Trar los commits del repositorio
      ///
      commits = await git.getCommits("$path/proyecto").catchError((error) {
        log(error.toString(), name: "Error traer commits");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      });
      pro.commits = commits;

      ///
      /// Traer el commit actual
      ///
      commit = await git.getCommit("$path/proyecto").catchError((error) {
        log(error.toString(), name: "Error traer commit");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      });
      pro.commit = commit;
    }
  }
}
