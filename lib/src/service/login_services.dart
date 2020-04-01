import 'dart:async';
import 'dart:io';
import 'package:ansor_build/src/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String walletId, userId, message;

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

  Future<bool> saveWalletId(String walletId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sessionId", walletId);
    return prefs.commit();
  }

  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sessionId", userId);
    return prefs.commit();
  }
}