import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';

import '../api/github_api.dart';
import '../model/proyecto_models/items_directory_model.dart';
import '../model/proyecto_models/proyecto_model.dart';
import '../services/manejo_archivos_services.dart';

class ProyectoProvider with ChangeNotifier {
  ProyectoProvider(ProyectoModel proyecto) {
    _proyecto = proyecto;
  }

  List<String>? branchs;
  List<String>? commits;
  List<ItemsDirectoryModel>? treefiles;
  String? commit;

  late ProyectoModel _proyecto;
  ProyectoModel get proyecto => _proyecto;
  set proyecto(ProyectoModel val) {
    _proyecto = val;
    notifyListeners();
  }

  bool _isGit = false;
  bool get isGit => _isGit;
  set isGit(bool val) {
    _isGit = val;
    notifyListeners();
  }

  Future<void> eliminarproyecto() async {
    await Directory(proyecto.path).delete(recursive: true);
    proyecto.delete();
  }

  Future<bool> guardarProyecto(
      {required String nombre,
      required String path,
      String? repositorio,
      String? img}) async {
    try {
      proyecto.nombre = nombre;

      if (proyecto.path != path) {
        await ManejoArchivosServices().moverProyecto(proyecto.path, path);
        proyecto.path = path;
      }
      if ((proyecto.repositorio ?? "").isNotEmpty &&
          (repositorio ?? "").isEmpty) {
        throw "No Puede dejar el repositorio vacio";
      } else {
        if (proyecto.repositorio != repositorio) {
          proyecto.repositorio = repositorio;
          _getrepoGithub();
        }
      }
      proyecto.save();
      return true;
    } catch (e) {
      log(e.toString(), name: 'guardarProyecto');
      rethrow;
    }
  }

  void _getrepoGithub() async {
    try {
      var repo = proyecto.repositorio!
          .replaceAll(RegExp(r"^https?://github.com/$"), "replace");

      var res = await GithubApi().get("repos/$repo");

      if (res["message"] != null) {
        throw "Error al obtener el repositorio";
      } else {
        var repo = RepositorioModel.fromMap(res);
        var box = Hive.box<RepositorioModel>('Repositorios');
        await box.put(repo.nodeId, repo);
        proyecto.repositorioMoel = box.get(repo.nodeId);

        final path = proyecto.path;
        var resColne = await Process.run(
            'git', ['clone', repo.cloneUrl, "$path/proyecto"]);
        if (resColne.exitCode != 0) throw resColne.stderr;

        proyecto.save();
      }
    } catch (e) {
      rethrow;
    }
  }

  // void getBranchRemote() async {
  //   var res =
  //       await GithubApi().get("repos/${proyecto.repositorio}/branches") as List;
  //   var branh = res.map((e) => e["name"]).toList();
  //   var uxbranchs = branh.removeWhere((element) => false)
  // }

  void getTree() async {
    var res = await ManejoArchivosServices()
        .getDirectoryTree("${proyecto.path}/proyecto");
    res?.removeWhere((element) => element.isEmpty);
    var data = res?.map((e) => ItemsDirectoryModel.fromString(e)).toList();
    treefiles = data;
  }
}
