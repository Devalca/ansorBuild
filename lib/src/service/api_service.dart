import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/model/user_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String userUid;
ApiService _apiService = ApiService();
String _url;

@override
void initState() {
  _apiService.getNameId().then(updateUrl);
  }
   
  
  class ApiService {
    String baseUrl = "http://192.168.10.11:3000";
  
      Future<Wallet> getSaldo() async {
       var response = await http.get(
        '$baseUrl/users/wallet/1',
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return Wallet.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    }
  
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
  
     Future<http.Response> postRegist(Users users) async {
      var response = await http.post(
        '$baseUrl/members/regist/',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: usersToJson(users),
      );
      return response;
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
  void updateUrl(String transUrl) {
    _url = transUrl;
}
