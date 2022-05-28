import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ManejoArchivosServices {
  static Future<String?> get localPath async {
    var _appDocDir = (await getDownloadsDirectory())?.path.split("/");
    _appDocDir?.removeLast();
    _appDocDir?.add("DevLab");
    var path = _appDocDir?.join("/");
    return path;
  }

  Future<String?> iniciarProyecto(String nombre) async {
    var box = Hive.box('deviceData');
    var path = box.get('HOMEPath');
    if (path != null) {
      var directory = await Directory.fromUri(Uri.parse("$path/$nombre"))
          .create(recursive: true);
      print("directory.path: ${directory.path}");
      return directory.path;
    } else {
      throw "No se encontro el directorio";
    }
  }
}
