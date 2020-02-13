import 'dart:convert';

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
