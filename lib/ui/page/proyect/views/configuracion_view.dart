import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../pestañas/configuracion.dart';

class ConfiguracionView extends StatefulWidget {
  const ConfiguracionView({Key? key}) : super(key: key);

  @override
  State<ConfiguracionView> createState() => _ConfiguracionViewState();
}

class _ConfiguracionViewState extends State<ConfiguracionView> {
  List<bool> _isOpen = [true, false];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        dividerColor: colorB,
        children: [
          ExpansionPanel(
            backgroundColor: colorA,
            isExpanded: _isOpen[0],
            headerBuilder: ((context, isExpanded) => Text(
                  "Proyecto",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            body:  Configuracion(),
          ),
        ],
        expansionCallback: (int index, bool isExpanded) {
          _isOpen = [false, false];
          setState(() {
            _isOpen[index] = true;
          });
        },
      ),
    );
  }
}
