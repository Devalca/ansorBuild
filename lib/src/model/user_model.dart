import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    String namaLengkap;
    String noHp;
    String email;
    String password;

    Users({
        this.namaLengkap,
        this.noHp,
        this.email,
        this.password,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        namaLengkap: json["nama_lengkap"],
        noHp: json["no_hp"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "no_hp": noHp,
        "email": email,
        "password": password,
    };
}
