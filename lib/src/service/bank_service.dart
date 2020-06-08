import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ansor_build/src/model/bank_model.dart';
import 'package:http/http.dart' as http;

class BankService {
  String title;
  BankService({this.title});

  String url = "http://103.9.125.18:3000";

  Future<Banks> fetchBank() async {
    final response = await http.get(
      '$url/master-data/namabank',
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return Banks.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Bank');
    }
  }
}
