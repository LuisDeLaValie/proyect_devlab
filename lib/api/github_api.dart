import 'dart:convert';
import 'dart:io';

import 'package:proyect_devlab/global/sesion.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  late Map<String, String> _headers;
  final String _baseUrl = 'api.github.com';

  GithubApi() {
    var git = Sesion.sesionGitHub;
    _headers = {
      HttpHeaders.acceptHeader: "application/json",
      if (git != null)
        HttpHeaders.authorizationHeader: "${git.tokenType} ${git.accessToken}",
    };
  }

  Future<dynamic> post(String path, [Map? data]) async {
    try {
      var url = Uri.https(_baseUrl, path);
      var res = await http.post(
        url,
        body: data,
        headers: _headers,
      );
      var datares = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      return datares;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get(
    String path, [
    Map? data,
    Map<String, dynamic>? queryParameters,
  ]) async {
    try {
      var request =
          http.Request('GET', Uri.https(_baseUrl, path, queryParameters));

      request.headers.addAll(_headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 6));

      return jsonDecode(await response.stream.bytesToString());
    } catch (e) {
      rethrow;
    }
  }
}
