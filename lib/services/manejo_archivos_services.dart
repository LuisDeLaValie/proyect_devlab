import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ManejoArchivosServices {
  static Future<String?> get localPath async {
    var appDocDir = (await getDownloadsDirectory())?.path.split("/");
    appDocDir?.removeLast();
    appDocDir?.add("DevLab");
    var path = appDocDir?.join("/");
    return path;
  }

  Future<String?> iniciarProyecto(String proyecto) async {
    try {
      var directory =
          await Directory.fromUri(Uri.parse(proyecto)).create(recursive: true);

      return directory.path;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> eliminarProyecto(String proyecto) async {
    try {
      await Directory(proyecto).delete(recursive: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> moverProyecto(String origen, String destino) async {
    try {
      await Directory(origen).rename(destino);
    } on FileSystemException catch (e) {
      if (e.osError?.errorCode == 2) {
        var aux = destino.split("/");
        aux.remove(destino.split("/").last);
        var dir = aux.join("/");
        throw "No se encontro el directorio $dir";
      }
      throw e.toString();
    }
  }

  Future<List<String>?> getDirectoryTree(String directory) async {
    try {
      var res = await Process.run('ls', ['-lah', directory], runInShell: true);
      if (res.exitCode != 0) throw res.stderr;

      var archAux = (res.stdout as String);
      var arch = archAux.split("\n");
      return arch;
    } catch (e) {
      rethrow;
    }
  }
}
