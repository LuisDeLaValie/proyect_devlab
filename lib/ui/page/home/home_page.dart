import 'package:flutter/material.dart';
import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';

import 'view/proyectos_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeDesktopLayout(
      title: "Desarrollo de Aplicaciones",
      body: ProyectosView(),
    );
  }
}
