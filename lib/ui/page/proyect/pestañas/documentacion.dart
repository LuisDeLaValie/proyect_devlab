import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdtxle_fonts/tdtxle_fonts.dart';

import '../../../../provider/proyecto_provider.dart';

class Documentacion extends StatefulWidget {
  const Documentacion({Key? key}) : super(key: key);

  @override
  State<Documentacion> createState() => _DocumentacionState();
}

class _DocumentacionState extends State<Documentacion> {
  @override
  initState() {
    super.initState();
    context.read<ProyectoProvider>().getDocumentos();
  }

  @override
  Widget build(BuildContext context) {
    var documentos = context.watch<ProyectoProvider>().documentos;
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            PopupMenuButton(
              icon: const Icon(Icons.add),
              tooltip: "Nuevo documento",
              onSelected: modalProyectoCrear,
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text(
                    'Markdown',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Documento',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text(
                    'Calculo',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text(
                    'Presentacion',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
            child: ListView(
          children: documentos?.map((e) {
                late IconData icon;
                if (e.nombre.contains('md')) {
                  icon = IconsTDTxLE.nf_mdi_markdown;
                }
                if (e.nombre.contains('odt')) {
                  icon = IconsTDTxLE.nf_mdi_file_word_box;
                }
                if (e.nombre.contains('ods')) {
                  icon = IconsTDTxLE.nf_mdi_file_excel_box;
                }
                if (e.nombre.contains('odp')) {
                  icon = IconsTDTxLE.nf_mdi_file_powerpoint_box;
                }

                return ListTile(
                  leading: Icon(icon),
                  title: Text(e.nombre),
                  onTap: () {
                    openFile(e.nombre);
                  },
                );
              }).toList() ??
              [],
        )),
      ],
    );
  }

  void modalProyectoCrear(int tipo) {
    late String _tipo;
    late String _documento;
    if (tipo == 0) {
      _tipo = 'md';
      _documento = 'nuevo Markdown';
    } else if (tipo == 1) {
      _tipo = 'odt';
      _documento = 'nuevo Documento';
    } else if (tipo == 2) {
      _tipo = 'ods';
      _documento = ' nueva Hoja de Calculo';
    } else if (tipo == 3) {
      _tipo = 'odp';
      _documento = 'nueva Presentacion';
    }
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text("Crear $_documento"),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Nombre del Archivo",
              ),
              onSubmitted: (val) => createDocumento(val, _tipo),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createDocumento(String nombre, String tipo) async {
    Navigator.of(context).pop();
    try {
      await context.read<ProyectoProvider>().crearDocumento(nombre, tipo);
    } catch (e) {
      log(e.toString(), name: '_DocumentacionState.createDocumento');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void openFile(String file) async {
    try {
      var path = context.read<ProyectoProvider>().proyecto.path;
      var res = await Process.run('open', ['$path/Documentos/$file'],
          runInShell: true);
      if (res.exitCode != 0) throw res.stderr;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
