import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyect_devlab/global/devices_data.dart';
import 'package:proyect_devlab/global/sesion.dart';
import 'package:proyect_devlab/services/navegacion_servies.dart';
import 'package:http/http.dart' as http;

import '../../../model/perfiles_model.dart';
import '../../shared/theme.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({Key? key}) : super(key: key);

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  late Timer timer1;
  late Timer timer2;
  String tiempocaduca = "";
  late GithubDevices githubDevices;
  @override
  void initState() {
    super.initState();
    contador();
  }

  void contador() {
    githubDevices = DevicesData.githubDevices!;
    // timer que actualiza el tiempo de vijencia del codigo
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      var aux = githubDevices.expiresIn.difference(DateTime.now());
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
    timer2 = Timer.periodic(
        Duration(seconds: githubDevices.interval), (timer) => validarCodigo());
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
              githubDevices.userCode,
              style: Theme.of(context).textTheme.headline3,
            ),
            if (timer1.isActive) Text("El codigo es valido por $tiempocaduca"),
            const SizedBox(height: 16),
            if (!timer1.isActive)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorB, onPrimary: colorC),
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
      DevicesData.githubDevices = GithubDevices.fromMap({
        'deviceCode': data['device_code'],
        'userCode': data['user_code'],
        'verificationUri': data['verification_uri'],
        'expiresIn': DateTime.now()
            .add(Duration(seconds: data['expires_in']))
            .millisecondsSinceEpoch,
        'interval': data['interval'],
      });
      contador();
    }
  }

  void validarCodigo() async {
    var res = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      body: {
        "client_id": DevicesData.githubClineteID,
        "device_code": githubDevices.deviceCode,
        "grant_type": "urn:ietf:params:oauth:grant-type:device_code"
      },
      headers: {
        "accept": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(res.bodyBytes)) as Map;

    if (data['interval'] != null) {
      var interval = data['interval'];
      DevicesData.githubDevices = githubDevices.copyWith(interval: interval);
      githubDevices = githubDevices.copyWith(interval: interval);
      timer2.cancel();
      timer2 = Timer.periodic(
          Duration(seconds: interval), (timer) => validarCodigo());
    }

    if (data['access_token'] != null) {
      timer1.cancel();
      timer2.cancel();

      var perfilbox = Hive.box<PerfilesModel>('Perfiles');
      var date = DateTime.now();

      Sesion.status = SesionStatus.login;
      Sesion.sesionGitHub =
          SesionGitHub.fromMap(Map<String, dynamic>.from(data));
      Sesion.perfil = date.millisecondsSinceEpoch.toString();

      await perfilbox.put(
        date.millisecondsSinceEpoch.toString(),
        PerfilesModel(
          id: date.millisecondsSinceEpoch.toString(),
          nombre: 'Personal',
          creado: date,
        ),
      );
      await Sesion.getAcountGithub();
      NavegacionServies.limpiar(homeRoute);
    }
  }
}
