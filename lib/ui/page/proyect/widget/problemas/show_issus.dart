import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_devlab/api/github_api.dart';

import '../../../../../model/github_models/issues_model.dart';
import '../../../../../provider/proyecto_provider.dart';
import 'view_md.dart';

class ShowIssus extends StatefulWidget {
  final IssuesModel? issus;
  ShowIssus({
    Key? key,
    this.issus,
  }) : super(key: key);

  @override
  State<ShowIssus> createState() => _ShowIssusState();
}

class _ShowIssusState extends State<ShowIssus> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IssuesModel>?>(
      future: getComents(),
      builder: (BuildContext context, snapshot) {
        return ListView(
          children: [
            Expanded(child: ViewMd(data: widget.issus!)),
            if (snapshot.connectionState == ConnectionState.waiting) ...[
              const SizedBox(height: 20),
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
            if (snapshot.connectionState == ConnectionState.done) ...[
              const SizedBox(height: 20),
              ...snapshot.data
                      ?.map((e) => Expanded(child: ViewMd(data: e)))
                      .toList() ??
                  [],
            ]
          ],
        );
      },
    );
  }

  Future<List<IssuesModel>?> getComents() async {
    try {
      // /repos/LuisDeLaValie/tdtxle_inputs_flutter/issues/1/comments
      var proyect = context.read<ProyectoProvider>().proyecto.repositorio!;
      var res = await GithubApi()
          .get("repos/$proyect/issues/${widget.issus?.number}/comments");
      print(res);
      var data = List<IssuesModel>.from(res.map((x) => IssuesModel.fromMap(x)));
      return data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return null;
    }
  }
}
