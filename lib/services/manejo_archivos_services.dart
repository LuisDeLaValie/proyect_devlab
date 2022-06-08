import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ManejoArchivosServices {
  static Future<String?> get localPath async {
    var appDocDir = (await getDownloadsDirectory())?.path.split("/");
    appDocDir?.removeLast();
    appDocDir?.add("DevLab");
    var path = appDocDir?.join("/");
    return path;
  }

  Future<String?> iniciarProyecto(String nombre) async {
    var box = Hive.box('deviceData');
    var path = box.get('HOMEPath');
    if (path != null) {
      var directory = await Directory.fromUri(Uri.parse("$path/$nombre"))
          .create(recursive: true);
      return directory.path;
    } else {
      throw "No se encontro el directorio";
    }
  }
}
