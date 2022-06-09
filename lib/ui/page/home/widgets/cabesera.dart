import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/services/manejo_archivos_services.dart';

import '../../../../services/navegacion_servies.dart';
import '../../../shared/theme.dart';

class Cabesera extends StatefulWidget {
  final void Function(String)? onChanged;
  const Cabesera({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<Cabesera> createState() => _CabeseraState();
}

class _CabeseraState extends State<Cabesera> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(onPressed: modalProyectoCrear, icon: const Icon(Icons.add)),
        const SizedBox(width: 10),
      ],
    );
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
