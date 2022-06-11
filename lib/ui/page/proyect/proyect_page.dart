import 'package:flutter/material.dart';

import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';

import 'views/curpo_general_view.dart';
import 'views/header_view.dart';

class ProyectPage extends StatelessWidget {
  const ProyectPage({Key? key}) : super(key: key);

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
