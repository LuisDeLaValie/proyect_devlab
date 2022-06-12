import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:proyect_devlab/ui/page/proyect/views/problemas_view.dart';

import '../widget/tab_bar_custom.dart';
import 'configuracion_view.dart';
import 'general_vew.dart';

class CurpoGeneralView extends StatelessWidget {
  const CurpoGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repr = context.watch<ProyectoProvider>().proyecto.repositorioMoel;
    print("CurpoGeneralView");
    return DefaultTabController(
      initialIndex: 0,
      length: repr != null ? 5 : 4,
      child: Column(
        children: [
          const TabBarCustom(),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                const GeneralVew(),
                const Center(child: Text('Archivos')),
                const Center(child: Text('Documentacion')),
                if (repr != null) const ProblemasView(),
                const ConfiguracionView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
