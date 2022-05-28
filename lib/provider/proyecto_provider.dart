import 'package:flutter/material.dart';

import '../model/proyecto_models/proyecto_model.dart';

class ProyectoProvider with ChangeNotifier {
  ProyectoProvider(ProyectoModel proyecto) {
    _proyecto = proyecto;
  }

  late ProyectoModel _proyecto;
  ProyectoModel get proyecto => _proyecto;
  set proyecto(ProyectoModel val) {
    _proyecto = val;
    notifyListeners();
  }

}
