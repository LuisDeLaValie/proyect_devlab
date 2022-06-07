import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio Con GitHub'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Inicio Con GitHub',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getCode,
              child: const Text('Ir a GitHub'),
            ),
          ],
        ),
      ),
    );
  }

  void getCode() async {
    var boxdevices = Hive.box('deviceData');

    var res = await http
        .post(Uri.parse("https://github.com/login/device/code"), body: {
      "client_id": boxdevices.get('github_client_id'),
      "scope": "repo user read:user user:email"
    }, headers: {
      "accept": "application/json"
    });

    var data = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    if (data['device_code'] != null && data['user_code'] != null) {
      await boxdevices.putAll({
        'device_code': data['device_code'],
        'user_code': data['user_code'],
        'verification_uri': data['verification_uri'],
        'expires_in': DateTime.now()
            .add(Duration(seconds: data['expires_in']))
            .toString(),
        'interval': data['interval'],
      });
      Hive.box('sesionData').put('sesion_status', SesionStatus.verifying.name);

      launchUrl(Uri.parse(data['verification_uri']));
      NavegacionServies.navigateToReplacement(loginCodigoRoute);
    }
  }
}
