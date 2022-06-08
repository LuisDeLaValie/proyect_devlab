import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyect_devlab/global/devices_data.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../shared/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
                onPrimary: colorC,
              ),
              onPressed: getCode,
              child: const Text('Ir a GitHub'),
            ),
          ],
        ),
      ),
    );
  }

  void getCode() async {
    var res = await http
        .post(Uri.parse("https://github.com/login/device/code"), body: {
      "client_id": DevicesData.githubClineteID,
      "scope": "repo user read:user user:email"
    }, headers: {
      "accept": "application/json"
    });

    var data = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    if (data['device_code'] != null && data['user_code'] != null) {
      DevicesData.githubDevices = GithubDevices.fromMap({
        'deviceCode': data['device_code'],
        'userCode': data['user_code'],
        'verificationUri': data['verification_uri'],
        'expiresIn': DateTime.now()
            .add(Duration(seconds: data['expires_in']))
            .millisecondsSinceEpoch,
        'interval': data['interval'],
      });
      Sesion.status = SesionStatus.verifying;

      launchUrl(Uri.parse(data['verification_uri']));
      NavegacionServies.navigateToReplacement(loginCodigoRoute);
    }
  }
}
