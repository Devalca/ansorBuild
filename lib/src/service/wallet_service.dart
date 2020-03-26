import 'dart:convert';

import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:http/http.dart' as http;

class WalletService {
// String baseUrl = "http://192.168.10.11:3000";
    String baseUrl = "https://afternoon-waters-38775.herokuapp.com";

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
  
}