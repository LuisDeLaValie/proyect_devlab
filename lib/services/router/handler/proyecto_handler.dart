import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/ui/page/proyect/proyect_page.dart';

import '../../../provider/proyecto_provider.dart';

class ProyectoHandler {
  static Handler proyecto = Handler(handlerFunc: (context, params) {
    var box = Hive.box<ProyectoModel>('Proyectos');
    var key = params['id']?.first;
    var proyecto = box.get(int.parse(key!));
    return ChangeNotifierProvider(
      create: (_) => ProyectoProvider(proyecto!),
      child: const ProyectPage(),
    );
  });
}
