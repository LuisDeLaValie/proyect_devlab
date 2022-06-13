import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/proyecto_provider.dart';
import '../../../../shared/theme.dart';

class HeaderButtons extends StatefulWidget {
  const HeaderButtons({Key? key}) : super(key: key);

  @override
  State<HeaderButtons> createState() => _HeaderButtonsState();
}

class _HeaderButtonsState extends State<HeaderButtons> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _size = context.size?.height ?? 0.0;
      });
    });
    super.initState();
  }

  double _size = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: colorB,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
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
          Container(
            width:  1,
            height: _size,
            color: colorC,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
          PopupMenuButton(
              offset: Offset(0, _size),
              onSelected: (int item) {},
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Item 1'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Item 2'),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text('Item 3'),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text('Item 4'),
                    ),
                  ])
        ],
      ),
    );
  }
}
