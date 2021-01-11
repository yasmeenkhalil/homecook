import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert' show json;
import 'dart:convert' as convert;

class networkhandler {
  String baseurl = 'https://homekitchen1.herokuapp.com/';
  var log = Logger();
  String t;
  FlutterSecureStorage storge = FlutterSecureStorage();
  get(String url) async {
    String token = await storge.read(key: "token");

    url = formater(url);
    final response = await http.get(url, headers: {"Authorization": token});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return convert.jsonDecode(response.body);
    }
  }

  Future newpost(String url, Map<String, dynamic> body) async {
    url = formater(url);

    var response = await http.post(url,
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    } else {
      if (response.statusCode == 401) {
        log.i(response.body);
        log.i(response.statusCode);
        return response;
      } else
        log.i(response);
      return response = null;
    }
  }

  Future put(String url, Map<String, dynamic> body) async {
    url = formater(url);

    String token = await storge.read(key: "token");

    print(token);
    var response = await http.put(url,
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
          "Authorization": token
        },
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    } else {
      if (response.statusCode == 401) {
        log.i(response.body);
        log.i(response.statusCode);
        return response;
      }
    }
  }

  Future post(String url, Map<String, dynamic> body) async {
    url = formater(url);
    String token = await storge.read(key: "token");

    var response = await http.post(url,
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
          "Authorization": token
        },
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    } else {
      if (response.statusCode == 401) {
        log.i(response.body);
        log.i(response.statusCode);
        return response;
      }
    }
  }

  Future patchimage(String url, String filePath) async {
    url = formater(url);
    String token = await storge.read(key: "token");

    var request = http.MultipartRequest('patch', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "content-type": "multipart/form-data",
      "Authorization": token,
    });

    var response = request.send();

    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }
}
