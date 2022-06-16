import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';
import '../../../../../services/manejo_archivos_services.dart';
import '../../../../shared/theme.dart';

class ArchivosTable extends StatefulWidget {
  const ArchivosTable({Key? key}) : super(key: key);

  @override
  State<ArchivosTable> createState() => _ArchivosTableState();
}

class _ArchivosTableState extends State<ArchivosTable> {
  @override
  Widget build(BuildContext context) {
    var treefiles = context.watch<ProyectoProvider>().archivos;

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: colorB, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      children: (treefiles != null)
          ? treefiles.sublist(1).map<TableRow>((e) {
              IconData icon = Icons.description;
              if (e.permisos[0] == "d" || e.permisos[0] == "l") {
                icon = Icons.folder;
              }

              return TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      onTap(e.permisos, e.nombre);
                    },
                    child: (e.permisos[0] == "l")
                        ? Tooltip(
                            message: "Enlace simbolico",
                            child: Row(
                              children: [
                                Icon(icon),
                                const SizedBox(width: 10),
                                Text(e.nombre)
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Icon(icon),
                              const SizedBox(width: 10),
                              Text(e.nombre)
                            ],
                          ),
                  ),
                  Text("${e.files} archivos"),
                  Text(e.peso),
                  Text(e.fecha),
                ],
              );
            }).toList()
          : [],
    );
  }

  void onTap(String permisos, String nombre) async {
    try {
      if (permisos[0] == "d") {
        var path = context.read<ProyectoProvider>().currentDirectory;
        path = path?.replaceAll(RegExp(r'[\w/]+proyecto/?'), '');
        context.read<ProyectoProvider>().getTree("$path/$nombre");
      } else if (permisos[0] == "l") {
      } else if (permisos[0] == "-") {
        var path = context.read<ProyectoProvider>().proyecto.path;
        var res =
            await Process.run('open', ['$path/proyecto'], runInShell: true);
        if (res.exitCode != 0) throw res.stderr;
      }
    } catch (e) {
      log(e.toString(), name: "ArchivosTable");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
