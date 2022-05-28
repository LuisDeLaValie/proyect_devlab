import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget {
  const TabBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      tabs: <Widget>[
        Tab(
          child: Text("General"),
        ),
        Tab(
          child: Text("Arcivos"),
        ),
        Tab(
          child: Text("Documentacion"),
        ),
        Tab(
          child: Text("Problemas"),
        ),
        Tab(
          child: Text("Configuracion"),
        ),
      ],
    );
  }
}
