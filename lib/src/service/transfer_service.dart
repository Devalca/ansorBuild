import 'dart:convert';
import 'dart:io';
import 'package:ansor_build/src/model/transfer_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransferServices {
  String baseUrl = "http://103.9.125.18:3000";

  Future<http.Response> postSesama(PostSesama sesama) async {
    var response = await http.post(
      '$baseUrl/transfer/unity',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(sesama),
    );
    return response;
  }

  Future<http.Response> postBank(PostBank bank) async {
    var response = await http.post(
      '$baseUrl/transfer/bank',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postBankToJson(bank),
    );
    return response;
  }

  Future<http.Response> putTransaksi(PutTransaksi transaksi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("transferId");

    var response = await http.put(
      '$baseUrl/transfer/transaction/$id',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: putTransaksiToJson(transaksi),
    );
    return response;
  }

  Future<History> history() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletId = prefs.getString("walletId");
    String userId = prefs.getString("userId");

    var response = await http.get(
        '$baseUrl/history/$userId/$walletId',
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return History.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
  }
}
