import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';

class RutaPath extends StatelessWidget {
  const RutaPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var path = context.watch<ProyectoProvider>().currentDirectory;
    path = path?.replaceAll(RegExp(r'[\w/]+proyecto/?'), '');
    var listaPath = path?.split('/');
    listaPath?.removeWhere((element) => element.isEmpty);
    if ((listaPath?.length ?? 0) == 0) return Container();
    var last = listaPath?.last;
    listaPath?.removeLast();
    return Row(
      children: [
        TextButton(
          onPressed: () {
            context.read<ProyectoProvider>().getTree();
          },
          child: Text(
            context.read<ProyectoProvider>().proyecto.nombre,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        for (var i = 0; i < (listaPath?.length ?? 0); i++) ...[
          const Text('/'),
          TextButton(
            onPressed: () {
              var aux = listaPath!.sublist(0, i + 1).join("/");
              context.read<ProyectoProvider>().getTree("/$aux");
            },
            child: Text(
              listaPath![i],
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
        const Text("/"),
        Text(last ?? ""),
      ],
    );
  }
}
