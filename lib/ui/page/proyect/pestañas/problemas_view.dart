import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/model/github_models/issues_model.dart';
import 'package:proyect_devlab/provider/proyecto_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/problemas/list_issus.dart';
import '../widget/problemas/show_issus.dart';

class ProblemasView extends StatefulWidget {
  const ProblemasView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProblemasViewState createState() => _ProblemasViewState();
}

class _ProblemasViewState extends State<ProblemasView> {
  bool showIsssus = false;
  IssuesModel? issus;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showIsssus
        ? ShowIssus(issus: issus)
        : ListIssus(
            onTap: (val) {
              setState(() {
                issus = val;
                showIsssus = true;
              });
            },
          );
  }
}
