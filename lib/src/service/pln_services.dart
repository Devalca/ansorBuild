import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ansor_build/src/model/pln_model.dart';

String id, transactionId, namaPelanggan;

class PlnServices{
  String baseUrl = "http://103.9.125.18:3000/ppob";

  Future<http.Response> postPascabayar(PostPascabayar pascabayar) async {
    var response = await http.post(
      '$baseUrl/pln/pascabayar',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(pascabayar),
    );
    return response;
  }
  Future<http.Response> postPascaTransaction(PostPascaTransaction pascaTransaction) async {
    var response = await http.post(
      '$baseUrl/pln/pascabayar/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: pascaTransactionToJson(pascaTransaction),
    );
    return response;
  }

  Future<http.Response> postPrabayar(PostPrabayar prabayar) async {
    var response = await http.post(
      '$baseUrl/pln/prabayar',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: prabayarToJson(prabayar),
    );
    return response;
  }

  Future<http.Response> postPraTransaction(PostPraTransaction praTransaction) async {
    var response = await http.post(
      '$baseUrl/pln/prabayar/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: praTransactionToJson(praTransaction),
    );
    return response;
  }

  Future<bool> saveTransactionId(String transactionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transactionId", transactionId);
    return prefs.commit();
  }

  Future<String> getTransactionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transactionId = prefs.getString("transactionId");
    return transactionId;
  }
}