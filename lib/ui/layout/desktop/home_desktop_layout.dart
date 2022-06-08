import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/global/devices_data.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/model/perfiles_model.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:tdtxle_inputs_flutter/inputs/img_perfil.dart';

class HomeDesktopLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  const HomeDesktopLayout({
    Key? key,
    required this.body,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ""),
        actions: const [
          UserAcount(),
        ],
      ),
      body: body,
    );
  }
}

class UserAcount extends StatefulWidget {
  const UserAcount({Key? key}) : super(key: key);

  @override
  State<UserAcount> createState() => _UserAcountState();
}

class _UserAcountState extends State<UserAcount> {
  @override
  Widget build(BuildContext context) {
    var boxPerfiles = Hive.box<PerfilesModel>("Perfiles");
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xff42414d),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          ImagenPerfil(
            imgPath: Sesion.avatar ?? "",
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Sesion.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF8F8F2),
                ),
              ),
              Text(
                (boxPerfiles.get(Sesion.perfil))?.nombre ?? "",
                style: const TextStyle(color: Color(0xffF8F8F2)),
              ),
            ],
          ),
          PopupMenuButton(
            tooltip: "",
            splashRadius: 0.1,
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              if (boxPerfiles.length > 1)
                PopupMenuItem(
                  child: const Text('Cambiar de perfil'),
                  onTap: () async {},
                ),
              PopupMenuItem(
                child: const Text('Cuenta'),
                onTap: () async {},
              ),
              PopupMenuItem(
                child: const Text('Configuracion'),
                onTap: () async {},
              ),
              PopupMenuItem(
                child: const Text('Cerrar Sesion'),
                onTap: () async {
                  await Hive.box('sesionData').clear();
                  await Hive.box('deviceData').clear();
                  Hive.box('Proyectos').clear();
                  Hive.box('Repositorios').clear();
                  Hive.box('Issues').clear();
                  Hive.box('Perfiles').clear();

                  DevicesData.initial();
                  await NavegacionServies.limpiar(loginRoute);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
