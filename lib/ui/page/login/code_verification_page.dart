import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CodeVerificationPage extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const CodeVerificationPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  late Timer timer1;
  late Timer timer2;
  String tiempocaduca = "";
  late int interval;

  @override
  void initState() {
    super.initState();
    var caduca = DateTime.parse(widget.arguments['expires_in']);
    interval = widget.arguments['interval'] ?? 5;

    // timer que actualiza el tiempo de vijencia del codigo
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      var aux = caduca.difference(DateTime.now());
      if (aux.inMinutes > 0) {
        setState(() {
          tiempocaduca = "${aux.inMinutes} minutos";
        });
      } else if (aux.inSeconds > 0) {
        setState(() {
          tiempocaduca = "${aux.inSeconds} segundos";
        });
      } else {
        timer1.cancel();
        timer2.cancel();
        setState(() {
          tiempocaduca = "";
        });
      }
    });

    // timer que en el que se verificara si el vodio es autorizado
    timer2 =
        Timer.periodic(Duration(seconds: interval), (timer) => validarCodigo());
  }

  @override
  void dispose() {
    timer1.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Code Verification',
              style: Theme.of(context).textTheme.headline6,
            ),
            SelectableText(
              widget.arguments['user_code'], 
              style: Theme.of(context).textTheme.headline3,
            ),
            if (timer1.isActive) Text("El codigo es valido por $tiempocaduca"),
            const SizedBox(height: 16),
            if (!timer1.isActive)
              ElevatedButton(
                onPressed: getCode,
                child: const Text('Nuevo codigo'),
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

  void validarCodigo() async {
    var res = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      body: {
        "client_id": widget.arguments['github_client_id'],
        "device_code": widget.arguments['device_code'],
        "grant_type": "urn:ietf:params:oauth:grant-type:device_code"
      },
      headers: {
        "accept": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(res.bodyBytes)) as Map;

    if (data['interval'] != null) {
      interval = data['interval'];
      Hive.box('deviceData').put('interval', interval);
      timer2.cancel();
      timer2 = Timer.periodic(
          Duration(seconds: interval), (timer) => validarCodigo());
    }

    if (data['access_token'] != null) {
      timer1.cancel();
      timer2.cancel();

      var box = Hive.box('sesionData');
      await box.putAll({
        'sesion_status': SesionStatus.login.name,
        'Github': {
          "access_token": "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",
          "token_type": "bearer",
        }
      });
      Sesion.getAcountGithub();
      NavegacionServies.limpiar(homeRoute);
    }
  }
}
