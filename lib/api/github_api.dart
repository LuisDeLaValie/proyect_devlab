import 'dart:convert';
import 'dart:io';

import 'package:proyect_devlab/global/sesion.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  late Map<String, String> _headers;
  final String _baseUrl = 'api.github.com';

  GithubApi() {
    String g = "${Sesion.github!.tokenType} ${Sesion.github!.accessToken}";
    _headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/vnd.github.v3+json",
      if (g != " ") HttpHeaders.authorizationHeader: g,
    };
  }

  Future<dynamic?> post(String path, [Map? data]) async {
    try {
      var res = await http.post(
        Uri.https(_baseUrl, path),
        body: data,
        headers: _headers,
      );
      var datares = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      return datares;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic?> get(
    String path, [
    Map? data,
    Map<String, dynamic>? queryParameters,
  ]) async {
    try {
    
      var request =
          http.Request('GET', Uri.https(_baseUrl, path, queryParameters));
      // http.Request('GET', Uri.parse('https://api.github.com/user/repos'));
      // http.Request('GET',
      //     Uri.parse('https://api.github.com/users/LuisDeLaValie/repos'));

      request.headers.addAll(_headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 3000));

      return jsonDecode(await response.stream.bytesToString());
    } catch (e) {
      rethrow;
    }
  }
}
