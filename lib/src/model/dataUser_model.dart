import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

DataUser dataUserFromJson(String str) => DataUser.fromJson(json.decode(str));
String dataUserToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
  List<DetailUser> data;
  String message;

  DataUser({
    this.data,
    this.message,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        data: List<DetailUser>.from(
            json["data"].map((x) => DetailUser.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
            data.map((x) => x.toJson())),
        "message": message,
      };
}

class DetailUser {
  int id;
  String namaLengkap;
  String noHp;
  String email;
  String password;
  int pin;
  String status;
  String aktifasi;
  DateTime createdAt;

  DetailUser(
      {this.id,
      this.namaLengkap,
      this.noHp,
      this.email,
      this.password,
      this.pin,
      this.status,
      this.aktifasi,
      this.createdAt});

  factory DetailUser.fromJson(Map<String, dynamic> json) => DetailUser(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        noHp: json["no_hp"],
        email: json["email"],
        password: json["password"],
        pin: json["pin"],
        status: json["status"],
        aktifasi: json["aktifasi"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "no_hp": noHp,
        "email": email,
        "password": password,
        "pin": pin,
        "status": status,
        "aktifasi": aktifasi,
        "createdAt": createdAt,
      };
}
