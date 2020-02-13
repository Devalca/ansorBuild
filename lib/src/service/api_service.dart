
import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/response/ansor_response.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

// class ApiService {

//   final String baseUrl = "http://192.168.10.31:3000/master-data";
//   final String ppobUrl = "http://192.168.10.31:3000/ppob";
//   Client client = Client();

//   Future<bool> createPdam(ScPdam data) async {
//   final response = await client.post(
//     "$baseUrl/pdam",
//     headers: {"content-type": "application/json"},
//     body: scPdamToJson(data),
//   );
//   if (response.statusCode == 201) {
//     print(response.body);
//     return true;
//   } else {
//     return false;
//   }
// }
// }

import 'package:http/http.dart' show Client;

class ApiService {

  final String baseUrl = "http://api.bengkelrobot.net:8001";
  Client client = Client();

  Future<List<Profile>> getProfiles() async {
    final response = await client.get("$baseUrl/api/profile");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
  final response = await client.post(
    "$baseUrl/api/profile",
    headers: {"content-type": "application/json"},
    body: profileToJson(data),
  );
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

}