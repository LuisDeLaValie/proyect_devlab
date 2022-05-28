import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:proyect_devlab/services/router/handler/home_handler.dart';
import 'package:proyect_devlab/services/router/handler/proyecto_handler.dart';

import '../navegacion_servies.dart';
import 'handler/login_handler.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static void configureRouter() {
    // login
    router.define(loginRoute,
        handler: LoginHandler.login, transitionType: TransitionType.none);
    router.define(loginCodigoRoute,
        handler: LoginHandler.verificar, transitionType: TransitionType.none);

    // home
    router.define(homeRoute,
        handler: HomeHandler.home, transitionType: TransitionType.none);
    // home
    router.define(proyectoRoute,
        handler: ProyectoHandler.proyecto, transitionType: TransitionType.none);

    router.notFoundHandler = _notfount;
  }

  static final Handler _notfount = Handler(handlerFunc: (context, params) {
    return const Scaffold(
      body: Center(
        child: Text("Not fount"),
      ),
    );
  });
}
