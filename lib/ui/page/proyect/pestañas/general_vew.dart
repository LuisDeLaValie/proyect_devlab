import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/proyecto_provider.dart';
import '../../../shared/theme.dart';
import '../widget/general/table_archivos.dart';
import '../widget/general/header_buttons.dart';
import '../widget/general/table_header.dart';

class GeneralVew extends StatelessWidget {
  const GeneralVew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                Spacer(),
                HeaderButtons(),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            // ignore: prefer_const_literals_to_create_immutables
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colorB, width: 2),
              ),
              child: Column(
                children: [
                  const TableHeader(),
                  Container(color: colorB, height: 2),
                  const ArchivosTable(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
