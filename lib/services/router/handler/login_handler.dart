import 'package:fluro/fluro.dart';
import 'package:proyect_devlab/ui/page/login/code_verification_page.dart';
import 'package:proyect_devlab/ui/page/login/login_page.dart';

class LoginHandler {
  static Handler login =
      Handler(handlerFunc: (context, params) => const LoginPage());
  static Handler verificar = Handler(
      handlerFunc: (context, params) => const CodeVerificationPage());
}
