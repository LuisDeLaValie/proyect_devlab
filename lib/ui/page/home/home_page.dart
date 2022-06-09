import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/services/manejo_archivos_services.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';
import 'package:proyect_devlab/ui/page/home/widgets/items_cards.dart';

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

  Future<List<Map<dynamic, dynamic>>?> getrepos() async {
    try {
      var res = (await GithubApi().get('/user/repos')) as List<dynamic>;
      var list = res.map((e) => Map<dynamic, dynamic>.from(e)).toList();
      return list;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

 }
