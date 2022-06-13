import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';

import '../../../provider/proyecto_provider.dart';
import 'views/curpo_general_view.dart';
import 'views/header_view.dart';

class ProyectPage extends StatefulWidget {
  const ProyectPage({Key? key}) : super(key: key);

  @override
  State<ProyectPage> createState() => _ProyectPageState();
}

class _ProyectPageState extends State<ProyectPage> {
  @override
  void initState() {
    context.read<ProyectoProvider>().getTree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeDesktopLayout(
      body: Column(
        children: const [
          HeaderView(),
          SizedBox(height: 5),
          Expanded(child: CurpoGeneralView())
        ],
      ),
    );
  }
}
