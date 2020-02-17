import 'package:ansor_build/src/model/ansor_model.dart';

class KontakResponse {
  bool status;
  String msg;
  List<Kontak> data;

  KontakResponse({this.status, this.msg, this.data});

  factory KontakResponse.fromJson(Map<String, dynamic> map) {
    // cast dynamic object to model (Kontak)
    var allKontak = map['data'] as List;
    List<Kontak> kontakList = allKontak.map((i) => Kontak.fromJson(i)).toList();

    return KontakResponse(
        status: map["status"], msg: map["message"], data: kontakList);
  }
}