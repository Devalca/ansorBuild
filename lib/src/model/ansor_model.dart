import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    int id;
    int walletId;
    String noHp;
    int nominal;
    int adminFee;
    String provider;
    int totalHarga;

    Post({
        this.id,
        this.walletId,
        this.noHp,
        this.nominal,
        this.adminFee,
        this.provider,
        this.totalHarga,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        walletId: json["walletId"],
        noHp: json["no_hp"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        provider: json["provider"],
        totalHarga: json["total_harga"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "no_hp": noHp,
        "nominal": nominal,
        "admin_fee": adminFee,
        "provider": provider,
        "total_harga": totalHarga,
    };
}
 
class Kontak {
  int id;
  String no_hp;
  int nominal;
 
  Kontak({this.id, this.no_hp, this.nominal});
 
  factory Kontak.fromJson(Map<String, dynamic> map) {
    return Kontak(
        id: map["id"],
        no_hp: map["no_hp"],
        nominal: map["nominal"]);
  }
 
  static List<Kontak> kontakFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Kontak>.from(data.map((item) => Kontak.fromJson(item)));
  }
}

class Profile {
  int id;
  String name;
  String email;
  int age;

  Profile({this.id = 0, this.name, this.email, this.age});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"], name: map["name"], email: map["email"], age: map["age"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "age": age};
  }

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, email: $email, age: $age}';
  }

}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class ScPdam {
  int id;
  String nama_wilayah;
  int no_pelanggan;

  ScPdam({this.id = 0, this.nama_wilayah, this.no_pelanggan});

  factory ScPdam.fromJson(Map<String, dynamic> map) {
    return ScPdam(
        id: map["id"], nama_wilayah: map["nama_wilayah"], no_pelanggan: map["no_pelanggan"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nama_wilayah": nama_wilayah, "no_pelanggan": no_pelanggan};
  }

  @override
  String toString() {
    return 'Wilayah{id: $id, nama_wilayah: $nama_wilayah, no_pelanggan: $no_pelanggan}';
  }

}

List<ScPdam> scPdamFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ScPdam>.from(data.map((item) => ScPdam.fromJson(item)));
}

String scPdamToJson(ScPdam data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
