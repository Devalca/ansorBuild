import 'dart:convert';

NamaWilayah namaWilayahFromJson(String str) => NamaWilayah.fromJson(json.decode(str));

String namaWilayahToJson(NamaWilayah data) => json.encode(data.toJson());

class NamaWilayah {
    List<Wilayah> data;
    String message;

    NamaWilayah({
        this.data,
        this.message,
    });

    factory NamaWilayah.fromJson(Map<String, dynamic> json) => NamaWilayah(
        data: List<Wilayah>.from(json["data"].map((x) => Wilayah.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Wilayah {
    int id;
    String namaWilayah;

    Wilayah({
        this.id,
        this.namaWilayah,
    });

    factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        id: json["id"],
        namaWilayah: json["nama_wilayah"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_wilayah": namaWilayah,
    };
}





// class ScPdam {
//   int id;
//   String namaWilayah;
//   int noPelanggan;

//   ScPdam({this.id = 0, this.namaWilayah, this.noPelanggan});

//   factory ScPdam.fromJson(Map<String, dynamic> map) {
//     return ScPdam(
//         id: map["id"],
//         namaWilayah: map["nama_wilayah"],
//         noPelanggan: map["no_pelanggan"]);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "nama_wilayah": namaWilayah,
//       "no_pelanggan": noPelanggan
//     };
//   }

//   @override
//   String toString() {
//     return 'Wilayah{id: $id, nama_wilayah: $namaWilayah, no_pelanggan: $noPelanggan}';
//   }
// }

// List<ScPdam> scPdamFromJson(String jsonData) {
//   final data = json.decode(jsonData);
//   return List<ScPdam>.from(data.map((item) => ScPdam.fromJson(item)));
// }

// String scPdamToJson(ScPdam data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }
