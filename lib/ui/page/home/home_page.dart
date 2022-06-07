import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/services/manejo_archivos_services.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:proyect_devlab/ui/layout/desktop/home_desktop_layout.dart';
import 'package:proyect_devlab/ui/page/home/widgets/items_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeDesktopLayout(
      title: "Desarrollo de Aplicaciones",
      body: ValueListenableBuilder<Box<ProyectoModel>>(
        valueListenable: Hive.box<ProyectoModel>('Proyectos').listenable(),
        builder: (context, box, widget) {
          var values = box.values.toList();
          return GridView.builder(
            itemCount: values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (_, index) => ItemsCards(
              repo: values[index],
            ),
          );
        },
      ),
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

  void modalProyectoCrear() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text("Crear nuevo Prollecto"),
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: "Nombre del proyecto",
            ),
            onSubmitted: createproyect,
          ),
        ],
      ),
    );
  }

  Future<void> createproyect(String nombre) async {
    Navigator.of(context).pop();
    try {
      var path = await ManejoArchivosServices().iniciarProyecto(nombre);
      var box = Hive.box<ProyectoModel>('Proyectos');
      var id = box.length;
      box.put(
          id,
          ProyectoModel(
            id: id,
            nombre: nombre,
            creador: "LuisDeLaValie",
            repositorio: "",
            path: path!,
            createAt: DateTime.now(),
          ));
      NavegacionServies.navigateTo(proyectoRoute.replaceAll(":id", "$id"));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
