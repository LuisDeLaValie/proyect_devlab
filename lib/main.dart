import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/global/devices_data.dart';
import 'package:proyect_devlab/model/github_models/issues_model.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'global/sesion.dart';
import 'model/perfiles_model.dart';
import 'services/navegacion_servies.dart';
import 'services/router/rout.dart';
import 'ui/shared/theme.dart';

void main() async {
  Flurorouter.configureRouter();
  await Hive.initFlutter();

// Register Adapter
  Hive.registerAdapter(ProyectoModelAdapter());
  Hive.registerAdapter(RepositorioModelAdapter());
  Hive.registerAdapter(PerfilesModelAdapter());

  var datasesion = await Hive.openBox('sesionData');
  var devicebox = await Hive.openBox('deviceData');
  await Hive.openBox<ProyectoModel>('Proyectos');
  await Hive.openBox<RepositorioModel>('Repositorios');
  await Hive.openBox<IssuesModel>('Issues');
  await Hive.openBox<PerfilesModel>('Perfiles');

  if (devicebox.isEmpty) DevicesData.initial();

  // log(datasesion.toMap().toString(), name: 'datasesion');
  // log(devicebox.toMap().toString(), name: 'devicebox');
  // Sesion.getAcountGithub();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String baseUrl;

  @override
  void initState() {
    super.initState();

    switch (Sesion.status) {
      case SesionStatus.login:
        baseUrl = homeRoute;
        break;
      case SesionStatus.logout:
        baseUrl = loginRoute;
        break;
      case SesionStatus.verifying:
        baseUrl = loginCodigoRoute;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevLab',
      theme: themaOscuro,
      debugShowCheckedModeBanner: false,
      initialRoute: baseUrl,
      navigatorKey: NavegacionServies.navigatorKey,
      onGenerateRoute: Flurorouter.router.generator,
      builder: (context, child) => child!,
    );
  }
}
