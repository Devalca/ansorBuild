import 'dart:async' show Future;
import 'dart:async';
import 'dart:io';
import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:http/http.dart' as http;


class PdamService {
  // String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
  // String baseUrl = "http://192.168.10.11:3000";
  String baseUrl = "http://103.9.125.18:3000";

  Future<NamaWilayah> getWilayah() async {
    var response = await http.get(
      '$baseUrl/master-data/namawilayah',
      headers: {"accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return namaWilayahFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<http.Response> createPostPdam(PostPdam postPdam) async {
    var response = await http.post(
      '$baseUrl/ppob/pdam/',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postPdamToJson(postPdam),
    );
    print("INI RESPONSE :" + response.body);
    return response;
  }

  Future<http.Response> createPdamPay(PostPdam postPdam) async {
     var response = await http.post(
        '$baseUrl/ppob/pdam/transaction',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postPdamToJson(postPdam),
      );
      print("INI RESPONSE Code:" + response.statusCode.toString());
      return response;
  }

  // Future<DetailPdam> getDetailId() async {
  //   final response = await http.get(
  //     '$baseUrl/ppob/pdam/1',
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     return detailPdamFromJson(response.body);
  //   } else {
  //     throw Exception('Failed to load album dan SATATUS CODE : ' +
  //         response.statusCode.toString());
  //   }
  // }
}