import 'dart:async';
import 'dart:io';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:http/http.dart' as http;
   
  
  class PulsaService {
    // String baseUrl = "http://192.168.10.11:3000";
    // String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
       String baseUrl = "http://103.9.125.18:3000";
  
    Future<ProviderCall> getProvider() async {
      var response = await http.get(
        '$baseUrl/master-data/namaprovider',
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return providerCallFromJson(response.body);
      } else {
        return null;
      }
    }
  
     Future<NominalList> getNominal() async {
      var response = await http.get(
        '$baseUrl/master-data/hargapulsa',
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return nominalListFromJson(response.body);
      } else {
        return null;
      }
    }
  
    Future<http.Response> createPost(Post post) async {
      var response = await http.post(
        '$baseUrl/ppob/pulsa/prabayar',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postToJson(post),
      );
      return response;
    }
  
    Future<http.Response> createPostPasca(Post post) async {
      var response = await http.post(
        '$baseUrl/ppob/pulsa/pascabayar',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postToJson(post),
      );
      print("INI RESPONSE :" + response.body );
      return response;
    }
  
    Future<http.Response> createPay(Post post) async {
      var response = await http.post(
        '$baseUrl/ppob/pulsa/prabayar/transaction',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postToJson(post),
      );
      return response;
    }
  
    Future<http.Response> createPayPasca(Post post) async {
      var response = await http.post(
        '$baseUrl/ppob/pulsa/pascabayar/transaction',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postToJson(post),
      );
      return response;
    }
  }