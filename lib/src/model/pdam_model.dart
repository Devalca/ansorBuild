import 'dart:convert';

class ScPdam {
  int id;
  String namaWilayah;
  int noPelanggan;

  ScPdam({this.id = 0, this.namaWilayah, this.noPelanggan});

  factory ScPdam.fromJson(Map<String, dynamic> map) {
    return ScPdam(
        id: map["id"],
        namaWilayah: map["nama_wilayah"],
        noPelanggan: map["no_pelanggan"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_wilayah": namaWilayah,
      "no_pelanggan": noPelanggan
    };
  }

  @override
  String toString() {
    return 'Wilayah{id: $id, nama_wilayah: $namaWilayah, no_pelanggan: $noPelanggan}';
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
