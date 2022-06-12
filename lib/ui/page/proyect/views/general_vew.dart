import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/proyecto_provider.dart';

class GeneralVew extends StatelessWidget {
  const GeneralVew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("GeneralVew");
    var isGit = context.watch<ProyectoProvider>().isGit;
    var commit = context.watch<ProyectoProvider>().commit;
    var commits = context.watch<ProyectoProvider>().commits;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          
          Row(
            children: [
              if (isGit) Text(showCommit(commit!, commits!)),
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
        ],
      ),
    );
  }

  String showCommit(String commit, List<String> commits) {
    var elcommit = commits.firstWhere((element) => element.contains(commit));
    var dataCommit = elcommit.split(" <> ");
    return "${dataCommit[0]} - ${dataCommit[2]} \t ${dataCommit[3]}";
  }
}
