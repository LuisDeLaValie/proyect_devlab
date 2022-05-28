import 'package:flutter/material.dart';

const String loginRoute = '/login';
const String loginCodigoRoute = '/login/code_verification';
const String homeRoute = '/home';
const String proyectoRoute = '/proyecto/:id';

// clase para manejar la navegacion entre paginas
class NavegacionServies {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> limpiar(String routeName,
      {Object? arguments, String? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(predicate ?? ""),
      arguments: arguments,
    );
  }

  static Future<dynamic> navigateToReplacement(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
