import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

enum SesionStatus { login, logout, verifying }

class Sesion {
  static final _box = Hive.box('sesionData');

  static String? get user => _box.get('user');
  static set user(String? val) {
    _box.put('user', val);
  }

  static String? get name => _box.get('name');
  static set name(String? val) {
    _box.put('name', val);
  }

  static String? get email => _box.get('email');
  static set email(String? val) {
    _box.put('email', val);
  }

  static String? get avatar => _box.get('avatar_url');
  static set avatar(String? val) {
    _box.put('avatar_url', val);
  }

  static SesionStatus get status => SesionStatus.values.byName(
      _box.get('sesion_status', defaultValue: SesionStatus.logout.name));
  static set status(SesionStatus val) {
    _box.put('sesion_status', val);
  }

  static SesionGitHub? get sesionGitHub {
    var data = _box.get('Github');
    if (data == null) {
      return SesionGitHub.fromMap(Map<String, dynamic>.from(data));
    } else {
      return null;
    }
  }

  static set sesionGitHub(SesionGitHub? val) {
    _box.put('Github', val);
  }

  static void getAcountGithub() async {
    var boxdevices = Hive.box('deviceData');

    var res = await http.post(
      Uri.parse("https://api.github.com/user"),
      body: {
        "client_id": boxdevices.get('github_client_id'),
        "device_code": boxdevices.get('device_code'),
        "grant_type": "urn:ietf:params:oauth:grant-type:device_code"
      },
      headers: {
        "Accept": "application/vnd.github.v3+json",
        "Authorization":
            "${sesionGitHub?.tokenType} ${sesionGitHub?.accessToken}",
      },
    );
    var data = jsonDecode(utf8.decode(res.bodyBytes)) as Map;

    var usergithub = sesionGitHub?.copyWith(
      perfil: data['html_url'],
      id: data['id'],
      user: data['login'],
      name: data['name'],
      avatarUrl: data['avatar_url'],
      email: data['email'],
    );

    _box.putAll({
      'user': data['login'],
      'name': data['name'],
      'avatar_url': data['avatar_url'],
      'email': data['email'],
      'Github': usergithub!.toMap()
    });
  }
}

class SesionGitHub {
  final int id;
  final String accessToken;
  final String tokenType;
  final String perfil;
  final String user;
  final String name;
  final String avatarUrl;
  final String email;
  SesionGitHub({
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.perfil,
    required this.user,
    required this.name,
    required this.avatarUrl,
    required this.email,
  });

  SesionGitHub copyWith({
    int? id,
    String? accessToken,
    String? tokenType,
    String? perfil,
    String? user,
    String? name,
    String? avatarUrl,
    String? email,
  }) {
    return SesionGitHub(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      perfil: perfil ?? this.perfil,
      user: user ?? this.user,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'access_token': accessToken,
      'token_type': tokenType,
      'perfil': perfil,
      'user': user,
      'name': name,
      'avatar_url': avatarUrl,
      'email': email,
    };
  }

  factory SesionGitHub.fromMap(Map<String, dynamic> map) {
    return SesionGitHub(
      id: map['id']?.toInt() ?? 0,
      accessToken: map['access_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      perfil: map['perfil'] ?? '',
      user: map['user'] ?? '',
      name: map['name'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SesionGitHub.fromJson(String source) =>
      SesionGitHub.fromMap(json.decode(source));
}
