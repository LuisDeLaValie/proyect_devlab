import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../api/github_api.dart';
import '../../../../../model/github_models/issues_model.dart';
import '../../../../../provider/proyecto_provider.dart';

class ListIssus extends StatefulWidget {
  final void Function(IssuesModel value) onTap;
  const ListIssus({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ListIssus> createState() => _ListIssusState();
}

class _ListIssusState extends State<ListIssus> {
  List<IssuesModel> listaIssues = [];
  int filter = 0;
  @override
  void initState() {
    getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auxLista = listaIssues.where(
      (element) {
        if (filter == 0) {
          return element.state.toLowerCase().contains("open");
        } else if (filter == 1) {
          return element.state.toLowerCase().contains("closed");
        } else {
          return true;
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<int>(
            value: filter,
            onChanged: (int? newValue) {
              setState(() {
                filter = newValue!;
              });
            },
            items: const [
              DropdownMenuItem<int>(
                value: 0,
                child: Text('open'),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: Text('closed'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: Text('all'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
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
                    Text("Labes"),
                    Text("Estado"),
                  ],
                ),
                ...auxLista
                    .map((e) => TableRow(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          children: [
                            TableRowInkWell(
                              onTap: () {
                                widget.onTap(e);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Row(
                                      children: [
                                        Text("Por ${e.creador}"),
                                        const SizedBox(width: 2),
                                        Text(fechaFormato(e.createdAt)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: e.labels?.map((label) {
                                        var color = Color(int.parse(
                                            "0xff${label.color }"));

                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Tooltip(
                                            message: label.name,
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor: color,
                                              radius: 12,
                                            ),
                                          ),
                                        );
                                      }).toList() ??
                                      []),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.state),
                            ),
                          ],
                        ))
                    .toList()
              ],
            ),
          ),
        ],
      ),
    );
  }

  String fechaFormato(DateTime fecha) {
    var dateAux = DateTime.now();
    var diferenbce = dateAux.difference(fecha);
    if (diferenbce.inDays == 2) return " Antier";
    if (diferenbce.inDays == 1) return " Ayer";
    if (diferenbce.inHours > 1) return " hace ${diferenbce.inHours} horas";
    if (diferenbce.inHours == 1) return " hace 1 hora";
    if (diferenbce.inMinutes > 1)
      return " hace ${diferenbce.inMinutes} minutos";
    if (diferenbce.inMinutes <= 1) return " hace 1 minuto";
    return "${fecha.day}/${fecha.month}/${fecha.year}";
  }

  void getIssues() async {
    final nombre =
        context.read<ProyectoProvider>().proyecto.repositorioMoel?.fullName ??
            "";
    try {
      var res = await GithubApi().get('repos/$nombre/issues', queryParameters: {
        'state': 'all',
        'direction': 'asc',
      });

      if (res is List) {
        listaIssues = res.map((e) => IssuesModel.fromMap(e)).toList();
        setState(() {});
      } else {
        throw res["message"];
      }
    } catch (e) {
      log(e.toString(), name: 'getIssues');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
