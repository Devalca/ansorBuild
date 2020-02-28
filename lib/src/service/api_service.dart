import 'dart:async';
import 'dart:io';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String userUid;

class ApiService {
  String baseUrl = "http://192.168.10.11:3000/ppob";

  Future<http.Response> createPost(Post post) async {
    var response = await http.post(
      '$baseUrl/pulsa/prabayar',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(post),
    );
    return response;
  }

    Future<http.Response> createPostPasca(Post post) async {
    var response = await http.post(
      '$baseUrl/pulsa/pascabayar',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(post),
    );
    print("INI RESPONSE :" + response.body );
    return response;
  }

  Future<http.Response> createPay(Post post) async {
    var response = await http.post(
      '$baseUrl/pulsa/prabayar/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(post),
    );
    return response;
  }

  Future<http.Response> createPayPasca(Post post) async {
    var response = await http.post(
      '$baseUrl/pulsa/pascabayar/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(post),
    );
    return response;
  }

  Future<bool> saveNameId(String transId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transId", transId);
    return prefs.commit();
  }

  Future<String> getNameId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transId = prefs.getString("transId");
    return transId;
  }
}

// Future<Album> fetchAlbum() async {
//           final response = await http.get('http://192.168.10.11:3000/ppob/pulsa/7');
//           print(response.body);
//           if (response.statusCode == 200) {
//             return albumFromJson(response.body);
//           } else {
//             throw Exception('Failed to load album');
//           }
//         }

// Future<List<Post>> getAllPost() async {
//   final response_1 = await http.get(baseUrl);
//   if(response_1.statusCode == 200) {
//     print(response_1.body);
//   } else {
//     print(response_1.statusCode);
//   }
// }
