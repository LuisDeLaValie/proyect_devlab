import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ManejoArchivosServices {
  void iniciarProyecto() async {
    var _appDocDir = await getDownloadsDirectory();
    // var _appDocDir = await getExternalStorageDirectories();

    // Process.run(r'echo', [r'$HOME']).then((result) {
    //   print(result.stderr);
    //   print(result.stdout);
    // });

    print(_appDocDir);
    Directory.fromUri(Uri.parse('/Users/emiliopartida/DevLab')) 
        .create(recursive: true)
        .then((Directory directory) {
      print("directory.path: ${directory.path}");
    });
  }
}
