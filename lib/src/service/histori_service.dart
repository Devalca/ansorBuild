import 'dart:convert';

import 'package:ansor_build/src/model/histori_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoriService {
// String baseUrl = "http://192.168.10.11:3000";
// String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
  String baseUrl = "http://103.9.125.18:3000";

  Future<Histori> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletId = prefs.getString("walletId");
    String userId = prefs.getString("userId");

    var response = await http.get(
      '$baseUrl/history/$userId/$walletId',
      headers: {"accept": "application/json"},
    );
    if (response.statusCode == 200) {
       return historiFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
