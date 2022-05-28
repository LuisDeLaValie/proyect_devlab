import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:proyect_devlab/ui/page/proyect/views/problemas_view.dart';

import '../widget/tab_bar_custom.dart';

class CurpoGeneralView extends StatelessWidget {
  const CurpoGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProyectoProvider>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: pro.proyecto.repositorioMoel != null ? 5 : 4,
      child: Column(
        children: [
          const TabBarCustom(),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                const Center(child: Text('General')),
                const Center(child: Text('Archivos')),
                const Center(child: Text('Documentacion')),
                if (pro.proyecto.repositorioMoel != null) const ProblemasView(),
                const Center(child: Text('Configuracion')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
