import 'package:fluro/fluro.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/ui/page/proyect/proyect_page.dart';

class ProyectoHandler {
  static Handler proyecto = Handler(handlerFunc: (context, params) {
    var repo = context?.settings?.arguments as ProyectoModel;
    return ProyectPage(
      proyecto: repo,
    );
  });
}
