import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/model/github_models/issues_model.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';

class ProblemasView extends StatefulWidget {
  const ProblemasView({Key? key}) : super(key: key);

  @override
  _ProblemasViewState createState() => _ProblemasViewState();
}

class _ProblemasViewState extends State<ProblemasView> {
  List<IssuesModel> listaIssues = [];
  @override
  void initState() {
    getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: [
          const TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            children: [
              Text("Titulo"),
              Text("Estado"),
              Text("Autor"),
              Text("Labes"),
              Text("creado"),
            ],
          ),
          ...listaIssues
              .map((e) => TableRow(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    children: [
                      Text(e.title),
                      Text(e.state),
                      Text(e.creador),
                      Wrap(
                          children: e.labels.map((label) {
                        var color =
                            Color(int.parse("0xff${label?.color ?? ""}"));

                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Tooltip(
                            message: label?.name,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 12,
                            ),
                          ),
                        );
                      }).toList()),
                      Text(e.createdAt.toString()),
                    ],
                  ))
              .toList()
        ],
      ),
    );
  }

  void getIssues() async {
    final nombre = Provider.of<ProyectoProvider>(context, listen: false)
            .proyecto
            .repositorioMoel
            ?.fullName ??
        "";
    try {
      var res = await GithubApi().get('repos/$nombre/issues') as List<dynamic>;

      setState(() {
        listaIssues = res.map((e) => IssuesModel.fromMap(e)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
