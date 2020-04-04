import 'dart:async';
import 'dart:io';

import 'package:ansor_build/src/model/user_model.dart';
import 'package:http/http.dart' as http;

class RegistService {
  String baseUrl = "http://103.9.125.18:3000";

  Future<http.Response> postRegist(Users users) async {
    var response = await http.post(
      '$baseUrl/members/regist/',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: usersToJson(users),
    );
    return response;
  }
}
