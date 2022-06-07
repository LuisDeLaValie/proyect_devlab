import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/model/github_models/issues_model.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'global/sesion.dart';
import 'services/manejo_archivos_services.dart';
import 'services/navegacion_servies.dart';
import 'services/router/rout.dart';

void main() async {
  Flurorouter.configureRouter();
  await Hive.initFlutter();

// Register Adapter
  Hive.registerAdapter(ProyectoModelAdapter());
  Hive.registerAdapter(RepositorioModelAdapter());
  Hive.registerAdapter(IssuesModelAdapter());

  var datasesion = await Hive.openBox('sesionData');
  var devicebox = await Hive.openBox('deviceData');
  await Hive.openBox<ProyectoModel>('Proyectos');
  await Hive.openBox<RepositorioModel>('Repositorios');
  await Hive.openBox<IssuesModel>('Issues');

  if (devicebox.isEmpty) {
    devicebox.put('github_client_id', 'c394dd917833466ceef1');
    ManejoArchivosServices.localPath.then((path) {
      devicebox.put('HOMEPath', path);
    });
  }
  log(datasesion.toMap().toString(), name: 'datasesion');
  log(devicebox.toMap().toString(), name: 'devicebox');

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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff44475A),
          elevation: 0,
          titleTextStyle: TextStyle(color: Color(0xffF8F8F2)),
        ),
        scaffoldBackgroundColor: const Color(0xff282a36),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: baseUrl,
      navigatorKey: NavegacionServies.navigatorKey,
      onGenerateRoute: Flurorouter.router.generator,
      builder: (context, child) => child!,
    );
  }
}
