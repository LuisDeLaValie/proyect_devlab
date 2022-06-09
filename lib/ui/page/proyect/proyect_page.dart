import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';

import '../../../provider/proyecto_provider.dart';
import '../../shared/theme.dart';
import 'views/curpo_general_view.dart';
import 'views/header_view.dart';

class ProyectPage extends StatelessWidget {
  final ProyectoModel proyecto;
  const ProyectPage({
    Key? key,
    required this.proyecto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeDesktopLayout(
      body: ChangeNotifierProvider(
        create: (_) => ProyectoProvider(proyecto),
        child: Column(
          children: const [
            HeaderView(),
            SizedBox(height: 5),
            Expanded(child: CurpoGeneralView())
          ],
        ),
      ),
    );
  }
}
