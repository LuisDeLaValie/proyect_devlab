import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyect_devlab/model/github_models/issues_model.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';
import 'package:proyect_devlab/model/proyecto_models/proyecto_model.dart';

import 'global/sesion.dart';
import 'services/navegacion_servies.dart';
import 'services/router/rout.dart';

void main() async {
  Flurorouter.configureRouter();
  await Hive.initFlutter();

// Register Adapter
  Hive.registerAdapter(ProyectoModelAdapter());
  Hive.registerAdapter(RepositorioModelAdapter());
  Hive.registerAdapter(IssuesModelAdapter());

  var sesion = await Hive.openBox('sesionData');
  var devicebox = await Hive.openBox('deviceData');

  devicebox.put('github_client_id', 'c394dd917833466ceef1');

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
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: baseUrl,
      navigatorKey: NavegacionServies.navigatorKey,
      onGenerateRoute: Flurorouter.router.generator,
      builder: (context, child) => child!,
    );
  }
}
