import 'dart:convert';

import 'package:hive/hive.dart';

import '../services/manejo_archivos_services.dart';

class DevicesData {
  static final _box = Hive.box('deviceData');

  static String get githubClineteID => _box.get('github_client_id');
  static set githubClineteID(String val) {
    _box.put('github_client_id', val);
  }

  static String get locapath => _box.get('HOMEPath');
  static set locapath(String val) {
    _box.put('HOMEPath', val);
  }

  static GithubDevices? get githubDevices {
    var data = _box.get('GITHUB_DEVICES');
    if (data != null) {
      return GithubDevices.fromMap(Map<String, dynamic>.from(data));
    } else {
      return null;
    }
  }

  static set githubDevices(GithubDevices? val) {
    _box.put('GITHUB_DEVICES', val?.toMap());
  }

  static void initial() async {
    var path = await ManejoArchivosServices.localPath;
    _box.putAll({
      'github_client_id': 'c394dd917833466ceef1',
      'HOMEPath': path,
    });
  }
}

class GithubDevices {
  final String deviceCode;
  final String userCode;
  final String verificationUri;
  final DateTime expiresIn;
  final int interval;

  GithubDevices._({
    required this.deviceCode,
    required this.userCode,
    required this.verificationUri,
    required this.expiresIn,
    required this.interval,
  });

  Map<String, dynamic> toMap() {
    return {
      'deviceCode': deviceCode,
      'userCode': userCode,
      'verificationUri': verificationUri,
      'expiresIn': expiresIn.millisecondsSinceEpoch,
      'interval': interval,
    };
  }

  factory GithubDevices.fromMap(Map<String, dynamic> map) {
    return GithubDevices._(
      deviceCode: map['deviceCode'] ?? '',
      userCode: map['userCode'] ?? '',
      verificationUri: map['verificationUri'] ?? '',
      expiresIn: DateTime.fromMillisecondsSinceEpoch(map['expiresIn']),
      interval: map['interval']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubDevices.fromJson(String source) =>
      GithubDevices.fromMap(json.decode(source));

  GithubDevices copyWith({
    String? deviceCode,
    String? userCode,
    String? verificationUri,
    DateTime? expiresIn,
    int? interval,
  }) {
    return GithubDevices._(
      deviceCode: deviceCode ?? this.deviceCode,
      userCode: userCode ?? this.userCode,
      verificationUri: verificationUri ?? this.verificationUri,
      expiresIn: expiresIn ?? this.expiresIn,
      interval: interval ?? this.interval,
    );
  }
}
