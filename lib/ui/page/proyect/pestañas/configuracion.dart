import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdtxle_inputs_flutter/inputs_tdtxle.dart';

import '../../../../provider/proyecto_provider.dart';
import '../../../shared/theme.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  var bordes = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      color: colorC,
      width: 1,
    ),
  );

  final nombre = TextEditingController();
  final path = TextEditingController();
  final repos = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var pro = context.read<ProyectoProvider>().proyecto;

    nombre.text = pro.nombre;
    path.text = pro.path;
    repos.text = pro.repositorio ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProyectoProvider>(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 300, minWidth: 80),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: nombre,
                    decoration: InputDecoration(
                      border: bordes,
                      enabledBorder: bordes,
                      focusedBorder: bordes,
                      labelText: "Nombre del proyecto",
                    ),
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "El nombre del proyecto es requerido";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      var aux = path.text.split("/");
                      aux[aux.length - 1] = value.replaceAll(" ", "_");
                      path.text = aux.join("/");
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 300, minWidth: 80),
                  child: TextFormField(
                    controller: repos,
                    decoration: InputDecoration(
                      border: bordes,
                      enabledBorder: bordes,
                      focusedBorder: bordes,
                      labelText: "Repositorio",
                      hintText: "Usuario/repositorio",
                    ),
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "El repositorio es requerido";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 600, minWidth: 100),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: path,
                decoration: InputDecoration(
                  border: bordes,
                  enabledBorder: bordes,
                  focusedBorder: bordes,
                  labelText: "Ubicación del proyecto",
                ),
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return "Este campo es obligatorio";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ImageFormField(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/img/belzebuth.png",
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: guardarProyecto,
              child: const Text("Guardar Cambios"),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text("Eliminar proyecto"),
                onPressed: () async {
                  try {
                    await pro.eliminarproyecto();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  guardarProyecto() {
    if (_formKey.currentState!.validate()) {
      try {
        context.read<ProyectoProvider>().guardarProyecto(
              nombre: nombre.text,
              path: path.text,
              repositorio: repos.text,
            );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    }
  }
}
