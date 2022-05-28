import 'package:flutter/material.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'views/header_view.dart';
import 'views/problemas_view.dart';
import 'widget/tab_bar_custom.dart';

class ProyectPage extends StatelessWidget {
  final ProyectoModel proyecto;
  const ProyectPage({
    Key? key,
    required this.proyecto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyect Page'),
      ),
      body: Column(
        children: [
          HeaderView(proyecto: proyecto),
          Container(
            color: Colors.black,
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 5,
              child: Column(
                children: [
                  TabBarCustom(),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        const Center(child: Text('General')),
                        const Center(child: Text('Archivos')),
                        const Center(child: Text('Documentacion')),
                        ProblemasView(
                          fullNameRepo:
                              proyecto.repositorioMoel?.fullName ?? "",
                        ),
                        const Center(child: Text('Configuracion')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
