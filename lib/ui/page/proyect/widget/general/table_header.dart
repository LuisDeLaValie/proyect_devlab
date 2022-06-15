import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';
import '../../../../shared/theme.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isGit = context.watch<ProyectoProvider>().isGit;
    var commit = context.watch<ProyectoProvider>().commit;
    var commits = context.watch<ProyectoProvider>().commits;
    return Container(
      color: colorB.withOpacity(0.4),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Spacer(),
          if (isGit) ...[
            Text(showCommit(commit ?? "", commits ?? [])),
          ],
        ],
      ),
    );
  }

  String showCommit(String commit, List<String> commits) {
    try {
      var elcommit = commits.firstWhere((element) => element.contains(commit));
      var dataCommit = elcommit.split(" <> ");
      return "${dataCommit[0]} - ${dataCommit[2]} \t ${dataCommit[3]}";
    } catch (e) {
      return "";
    }
  }
}
