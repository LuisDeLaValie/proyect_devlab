class ItemsDirectoryModel {
  final String permisos;
  final String files;
  final String peso;
  final String fecha;
  final String nombre;
  ItemsDirectoryModel({
    required this.permisos,
    required this.files,
    required this.peso,
    required this.fecha,
    required this.nombre,
  });

  factory ItemsDirectoryModel.fromString(String datos) {
    if (datos.toLowerCase().contains("total")) {
      return ItemsDirectoryModel(
        permisos: "",
        files: "",
        peso: "",
        fecha: "",
        nombre: datos,
      );
    }
    var permisos = datos.substring(0, 10);
    var aux = datos.replaceFirst(RegExp(permisos), "");

    var fiels = aux.split(" ").firstWhere((element) => element.isNotEmpty);
    aux = aux.replaceFirst(RegExp(" +$fiels \\w+ +\\w+ +"), "");

    var peso = aux.split(" ").first;
    aux = aux.replaceFirst(RegExp("$peso +"), "");

    var fecha = RegExp(r"\w{3} \d{1,2} \d{1,2}:\d{1,2}")
            .allMatches(aux)
            .first
            .group(0) ??
        "";
    aux = aux.replaceFirst(RegExp("$fecha +"), "");

    var nombre = aux;

    return ItemsDirectoryModel(
      permisos: permisos,
      files: fiels,
      peso: peso,
      fecha: fecha,
      nombre: nombre,
    );
  }
}
