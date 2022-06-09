import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import '../widgets/cabesera.dart';
import '../widgets/items_cards.dart';

class ProyectosView extends StatefulWidget {
  const ProyectosView({Key? key}) : super(key: key);

  @override
  State<ProyectosView> createState() => _ProyectosViewState();
}

class _ProyectosViewState extends State<ProyectosView> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ProyectoModel>>(
      valueListenable: Hive.box<ProyectoModel>('Proyectos').listenable(),
      builder: (context, box, widget) {
        var values = lista(box.values);
        var size = MediaQuery.of(context).size.width;
        var ta = size ~/ 180;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Cabesera(
                onChanged: (val) {
                  setState(() {
                    search = val;
                  });
                },
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ta,
                  ),
                  itemBuilder: (_, index) => ItemsCards(
                    repo: values[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<ProyectoModel> lista(Iterable<ProyectoModel> values) {
    return values
        .toList()
        .where((element) =>
            element.nombre.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}
