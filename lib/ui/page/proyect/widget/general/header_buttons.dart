import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';
import 'custon_button_papup.dart';

class HeaderButtons extends StatelessWidget {
  const HeaderButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustonButtonPapup(
      text: "Abrir",
      onTap: () async {
        try {
          var path = context.read<ProyectoProvider>().proyecto.path;
          var res =
              await Process.run('open', ['$path/proyecto'], runInShell: true);
          if (res.exitCode != 0) throw res.stderr;
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      },
      itemBuilder: (build) => [
         PopupMenuItem(
          value: 0,
          child: const Text("Buscador"),
          onTap: () async {
            try {
              var path = context.read<ProyectoProvider>().proyecto.path;
              var res = await Process.run('open', ['$path/proyecto'],
                  runInShell: true);
              if (res.exitCode != 0) throw res.stderr;
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
              ));
            }
          },
        ),
         PopupMenuItem(
          value: 0,
          child: const Text("Editor"),
           onTap: () async {
            try {
              var path = context.read<ProyectoProvider>().proyecto.path;
              var res = await Process.run('code', ['$path/proyecto'],
                  runInShell: true);
              if (res.exitCode != 0) throw res.stderr;
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
              ));
            }
          },
        ),
      ],
    );
  }
}
