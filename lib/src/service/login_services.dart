import 'dart:async';
import 'dart:io';
import 'package:ansor_build/src/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String sessionId, message;

class LoginServices{
  String baseUrl = "http://192.168.10.11:3000";

  Future<http.Response> postLogin(PostLogin login) async {
    var response = await http.post(
      '$baseUrl/members/login',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: loginToJson(login),
    );
    return response;
  }

  Future<bool> saveSessionId(String transactionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sessionId", sessionId);
    return prefs.commit();
  }
}