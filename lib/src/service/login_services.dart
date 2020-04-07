import 'dart:async';
import 'dart:io';
import 'package:ansor_build/src/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices{
  String baseUrl = "http://103.9.125.18:3000";

  Future<http.Response> postLogin(PostLogin login) async {
    var response = await http.post(
      '$baseUrl/members/login',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: loginToJson(login),
    );
    return response;
  }
}