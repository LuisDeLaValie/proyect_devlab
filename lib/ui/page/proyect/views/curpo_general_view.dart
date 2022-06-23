import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:proyect_devlab/ui/page/proyect/pesta%C3%B1as/problemas_view.dart';
import 'package:tdtxle_fonts/tdtxle_fonts.dart';

import '../pestañas/documentacion.dart';
import '../pestañas/problemas_view.dart';
import 'configuracion_view.dart';
import '../pestañas/general_vew.dart';

class CurpoGeneralView extends StatelessWidget {
  const CurpoGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repr = context.watch<ProyectoProvider>().proyecto.repositorioMoel;
    var auxPro = repr != null;
    var lista = generateList(souwPorblem: auxPro);
    return DefaultTabController(
      initialIndex: 0,
      length: lista.length,
      child: Column(
        children: [
          TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: lista
                .map((e) => Tab(
                      icon: Icon(e['icon']),
                      child: Text(e['name']),
                    ))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children: lista.map((e) => e['page'] as Widget).toList(),
            ),
          )
        ],
      ),
    );
  }

  List<Map<String, dynamic>> generateList({required bool souwPorblem}) {
    return [
      {
        'name': 'General',
        'icon': IconsTDTxLE.nf_mdi_file_tree,
        'page': const GeneralVew(),
      },
      {
        'name': 'Documentos',
        'icon': IconsTDTxLE.nf_mdi_file_document_box,
        'page': const Documentacion(),
      },
      if (souwPorblem)
        {
          'name': 'Problemas',
          'icon': Icons.error,
          'page': const ProblemasView(),
        },
      {
        'name': 'Configuración',
        'icon': Icons.settings,
        'page': const ConfiguracionView(),
      },
    ];
  }
}
