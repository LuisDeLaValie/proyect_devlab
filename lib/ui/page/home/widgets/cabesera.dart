import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/global/devices_data.dart';
import 'package:proyect_devlab/global/sesion.dart';

import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';
import 'package:proyect_devlab/services/manejo_archivos_services.dart';

import '../../../../model/perfiles_model.dart';
import '../../../../services/navegacion_servies.dart';

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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Nombre del proyecto",
              ),
              onSubmitted: createproyect,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createproyect(String nombre) async {
    Navigator.of(context).pop();
    try {
      var sesion =
          Hive.box<PerfilesModel>('Perfiles').get(Sesion.perfil)?.nombre;
      if (sesion == null) throw "Error a obtener directrio";
      var auxpath =
          "${DevicesData.locapath}/$sesion/${nombre.replaceAll(" ", "_")}";

      var path = await ManejoArchivosServices().iniciarProyecto(auxpath);
      var box = Hive.box<ProyectoModel>('Proyectos');
      var id = box.length;

      box.put(
          id,
          ProyectoModel(
            id: id,
            nombre: nombre,
            creador: Sesion.name ?? "",
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
