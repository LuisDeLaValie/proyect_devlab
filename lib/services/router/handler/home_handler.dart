import 'package:fluro/fluro.dart';
import 'package:proyect_devlab/ui/page/home/home_page.dart';

class HomeHandler {
  static Handler home =
      Handler(handlerFunc: (context, params) => const HomePage());
}
