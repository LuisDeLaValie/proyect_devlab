import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';

import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProyectoProvider>(context);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pro.proyecto.nombre,
                style: Theme.of(context).textTheme.headlineMedium),
            if (pro.proyecto.repositorio.isEmpty)
              TextButton(
                onPressed: addRepositorio,
                child: const Text('Agrege un repositorio'),
              ),
            if (pro.proyecto.repositorioMoel != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              pro.proyecto.repositorioMoel?.creadorUrl ?? ""));
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
                      launchUrl(Uri.parse(pro.proyecto.repositorio));
                    },
                    icon: Icon((pro.proyecto.repositorioMoel?.private ?? false)
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

  void addRepositorio() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text("Agregar repositorio"),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "${Sesion.sesionGitHub?.user}/{repo}",
            ),
            onSubmitted: getInfoRepo,
          ),
        ],
      ),
    );
  }

  Future<String> clonarrepo(String clonar) async {
    try {
      final path =
          Provider.of<ProyectoProvider>(context, listen: false).proyecto.path;

      var repo = await Process.run('git', ['clone', clonar, "$path/proyecto"]);
      if (repo.exitCode == 0) {
        return "Repositorio Cloneado";
      } else {
        throw repo.stderr;
      }
    } catch (e) {
      return e.toString();
    }
  }

  getInfoRepo(String repo) async {
    Navigator.of(context).pop();
    var aux = repo.replaceAll(" ", "");
    final pro = Provider.of<ProyectoProvider>(context, listen: false);
    try {
      var res = await GithubApi().get("repos/$aux");
      if (res["message"] != null) {
        throw "Error al obtener el repositorio";
      } else {
        var nodid = res["node_id"];
        var repobox = Hive.box<RepositorioModel>('Repositorios');
        await repobox.put(nodid, RepositorioModel.fromMap(res));
        var repo = repobox.get(nodid);

        pro.proyecto
          ..repositorioMoel = repo
          ..repositorio = repo!.htmlUrl;
        pro.proyecto.save();
        pro.proyecto = pro.proyecto;
        clonarrepo(repo.cloneUrl);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
