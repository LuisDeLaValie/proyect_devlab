import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../provider/proyecto_provider.dart';

class TabBarCustom extends StatelessWidget {
  const TabBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProyectoProvider>(context);
    return TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      tabs: <Widget>[
        const Tab(child: Text("General")),
        const Tab(child: Text("Arcivos")),
        const Tab(child: Text("Documentacion")),
        if (pro.proyecto.repositorioMoel != null)
          const Tab(child: Text("Problemas")),
        const Tab(child: Text("Configuracion")),
      ],
    );
  }
}
