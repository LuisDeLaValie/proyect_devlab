import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import '../../../provider/proyecto_provider.dart';
import 'views/curpo_general_view.dart';
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
        title: const Text('Proyect Page'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProyectoProvider(proyecto),
        child: Column(
          children: [
            const HeaderView(),
            Container(
              color: Colors.black,
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            const Expanded(child: CurpoGeneralView())
          ],
        ),
      ),
    );
  }


}
