import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/ui/page/login/code_verification_page.dart';
import 'package:proyect_devlab/ui/page/login/login_page.dart';

class LoginHandler {
  static Handler login =
      Handler(handlerFunc: (context, params) => const LoginPage());
  static Handler verificar = Handler(handlerFunc: (context, params) {
    var box = Hive.box('deviceData');
    Map<String, dynamic> args = Map<String, dynamic>.from(box.toMap());
    return CodeVerificationPage(arguments: args);
  });
}
