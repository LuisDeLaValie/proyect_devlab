import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';

class BrobbutonBracnhs extends StatelessWidget {
  const BrobbutonBracnhs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var branch = context.watch<ProyectoProvider>().branchs;
    var selectbranc = branch?.firstWhere((b) => b.contains("*"));
    return DropdownButton<String>(
      value: selectbranc,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        // setState(() {
        //   dropdownValue = newValue!;
        // });
      },
      items: branch?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.replaceFirst("* ", "")),
        );
      }).toList(),
    );
  }
}
