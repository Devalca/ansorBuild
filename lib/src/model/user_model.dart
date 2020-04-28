import 'dart:convert';

MasterUser masterUserFromJson(String str) =>
    MasterUser.fromJson(json.decode(str));
String masterUserToJson(MasterUser data) => json.encode(data.toJson());

class MasterUser {
  int id;
  String namaLengkap;
  String noHp;
  String email;
  String password;
  int pin;
  String status;
  DateTime createdAt;

  MasterUser({
    this.id,
    this.namaLengkap,
    this.noHp,
    this.email,
    this.password,
    this.pin,
    this.status,
    this.createdAt,
  });

  factory MasterUser.fromJson(Map<String, dynamic> json) => MasterUser(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        noHp: json["no_hp"],
        email: json["email"],
        password: json["password"],
        pin: json["pin"],
        status: json["status"],
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
        "createdAt": createdAt.toIso8601String(),
      };
}

Users usersFromJson(String str) => Users.fromJson(json.decode(str));
String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String namaLengkap;
  String noHp;
  String email;
  String password;
  int pin;

  Users({
    this.namaLengkap,
    this.noHp,
    this.email,
    this.password,
    this.pin,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        namaLengkap: json["nama_lengkap"],
        noHp: json["no_hp"],
        email: json["email"],
        password: json["password"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "no_hp": noHp,
        "email": email,
        "password": password,
        "pin": pin,
      };
}
