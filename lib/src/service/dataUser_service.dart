import 'dart:convert';
import 'package:ansor_build/src/model/dataUser_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataUserService {
  String baseUrl = "http://103.9.125.18:3000";

  Future<DataUser> getDataUser() async {
    var response = await http.get(
      '$baseUrl/master-data/users',
      headers: {"accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return DataUser.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to load data user');
    }
  }
}
