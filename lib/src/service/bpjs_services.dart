import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ansor_build/src/model/bpjs_model.dart';

String transactionId;

class BpjsServices {
  String url = "http://103.9.125.18:3000";

  Future<Bulan> fetchBulan() async {
    final response = await http.get(
      '$url/master-data/bulanbayar',
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return Bulan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Bulan');
    }
  }

  Future<Bayar> fetchBayar() async {
    final response = await http.get(
      '$url/master-data/bayaruntuk',
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return Bayar.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Bulan');
    }
  }

  Future<http.Response> postKesehatan(PostKesehatan kesehatan) async {
    var response = await http.post(
      '$url/ppob/bpjs/kesehatan',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: kesehatanToJson(kesehatan),
    );
    return response;
  }

  Future<http.Response> postKetenagakerjaan(PostKetenagakerjaan ketenagakerjaan) async {
    var response = await http.post(
      '$url/ppob/bpjs/ketenagakerjaan',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: ketenagakerjaanToJson(ketenagakerjaan),
    );
    return response;
  }

  Future<http.Response> postPembayaran(PostPembayaran pembayaran) async {
    var response = await http.post(
      '$url/ppob/bpjs/kesehatan/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: pembayaranToJson(pembayaran),
    );
    return response;
  }

  Future<http.Response> postBayarKerja(PostBayarKerja bayarKerja) async {
    var response = await http.post(
      '$url/ppob/bpjs/ketenagakerjaan/transaction',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: bayarKerjaToJson(bayarKerja),
    );
    return response;
  }
}

