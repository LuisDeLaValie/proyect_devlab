import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/proyecto_models/items_directory_model.dart';
import '../../../../provider/proyecto_provider.dart';
import '../../../shared/theme.dart';

class GeneralVew extends StatelessWidget {
  const GeneralVew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("GeneralVew");
    var isGit = context.watch<ProyectoProvider>().isGit;
    var commit = context.watch<ProyectoProvider>().commit;
    var commits = context.watch<ProyectoProvider>().commits;
    var treefiles = context.watch<ProyectoProvider>().treefiles;
    treefiles?.removeAt(0);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
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
                  child: const Text("Abrir"),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            // ignore: prefer_const_literals_to_create_immutables
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colorB, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    color: colorB.withOpacity(0.4),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Spacer(),
                        if (isGit) ...[
                          Text(showCommit(commit!, commits!)),
                        ],
                      ],
                    ),
                  ),
                  Container(color: colorB, height: 2),
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: colorB, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    children: [
                      ...treefiles?.sublist(1).map<TableRow>((e) {
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
                          }).toList() ??
                          [],
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String showCommit(String commit, List<String> commits) {
    var elcommit = commits.firstWhere((element) => element.contains(commit));
    var dataCommit = elcommit.split(" <> ");
    return "${dataCommit[0]} - ${dataCommit[2]} \t ${dataCommit[3]}";
  }
}
