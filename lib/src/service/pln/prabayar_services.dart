import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ansor_build/src/model/pln/api_response.dart';
import 'package:ansor_build/src/model/pln/prabayar_insert.dart';

class PrabayarServices {

  static const API = 'http://192.168.10.11:3000/';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<APIResponse<bool>> createPrabayar(PrabayarInsert item){
    return http.post(API + 'ppob/pln/prabayar',  headers: headers, body: json.encode(item.toJson()))
    .then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(
          data: true
        );
      }else{
        return APIResponse<bool>(
          error: true,
          errorMessage: 'An error occured api'
        );
      }
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured catch'));
  }
}