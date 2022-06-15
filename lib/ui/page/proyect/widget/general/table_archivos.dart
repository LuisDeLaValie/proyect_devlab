import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';
import '../../../../shared/theme.dart';

class ArchivosTable extends StatelessWidget {
  const ArchivosTable({Key? key}) : super(key: key);

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
              if (e.permisos[0] == "d") {
                icon = Icons.folder;
              }
              return TableRow(
                children: [
                  Row(
                    children: [
                      Icon(icon),
                      const SizedBox(width: 10),
                      Text(e.nombre),
                    ],
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
}
