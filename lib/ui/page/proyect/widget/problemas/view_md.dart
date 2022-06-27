import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:proyect_devlab/ui/shared/theme.dart';

import '../../../../../model/github_models/issues_model.dart';

class ViewMd extends StatelessWidget {
  final IssuesModel data;
  const ViewMd({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: colorC),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colorB,
              // border: Border.all(color: colorC),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Text(data.creador),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: MarkdownBody(
              data: parseimg(data.body),
              selectable: true,
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  md.EmojiSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
              styleSheet: MarkdownStyleSheet(
                blockquoteDecoration: BoxDecoration(
                  color: colorD,
                  border: Border(
                    left: BorderSide(width: 3, color: colorC),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String parseimg(String data) {
    var dataAux = data;

    var exp = RegExp(r'<img [\w=":/ \.-]+ */*>');
    var machs = exp.allMatches(data);
    for (var item in machs) {
      var dato = item[0] ?? "";
      String? wh, alt, src;

      // obtener el alt de un <img/>
      var realt = RegExp('alt *= *("|\').*?("|\')');
      if (realt.hasMatch(dato)) {
        alt = (realt.firstMatch(dato)?[0] ?? "")
            .replaceAll(RegExp('alt *= *("|\')|("|\')'), "");
      }
      // obtener el rsc de un <img/>
      var resrc = RegExp('src *= *("|\').*?("|\')');
      if (resrc.hasMatch(dato)) {
        src = (resrc.firstMatch(dato)?[0] ?? "")
            .replaceAll(RegExp('src *= *("|\')|("|\')'), "");
      }

      // obtener el width y el height de un <img/>
      var reswha = RegExp("(width|height) *= *(\"|')[0-9]*?(\"|')");
      if (reswha.hasMatch(dato)) {
        //
        var aux = reswha
            .allMatches(dato)
            .toList()
            .map((e) => RegExp("(?<=[\"|'])(.*?)(?=[\"|'])")
                .firstMatch(e[0] ?? "")?[0]!)
            .toList();

        if (aux.length == 1) {
          wh = "#${aux[0]}x${aux[0]}";
        } else if (aux.length == 2) {
          wh = "#${aux[0]}x${aux[1]}";
        }

        // width=aux[0][0];
        // width=aux[1][0];

      }
      dataAux =
          dataAux.replaceAll(dato, "![${alt ?? ""}](${src ?? ""}${wh ?? ""})");
    }

    return dataAux;
  }
}
