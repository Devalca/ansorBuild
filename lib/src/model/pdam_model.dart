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

PostPdam postPdamFromJson(String str) => PostPdam.fromJson(json.decode(str));

String postPdamToJson(PostPdam data) => json.encode(data.toJson());

class PostPdam {
    int id;
    String noPelanggan;
    String namaPelanggan;
    String namaWilayah;
    int tagihan;
    int total;

    PostPdam({
        this.id,
        this.noPelanggan,
        this.namaPelanggan,
        this.namaWilayah,
        this.tagihan,
        this.total
    });

    factory PostPdam.fromJson(Map<String, dynamic> json) => PostPdam(
        id: json["id"],
        noPelanggan: json["no_pelanggan"],
        namaPelanggan: json["nama_pelanggan"],
        namaWilayah: json["nama_wilayah"],
        tagihan: json["tagihan"],
        total: json["total"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_pelanggan": noPelanggan,
        "nama_pelanggan": namaPelanggan,
        "nama_wilayah": namaWilayah,
        "tagihan": tagihan,
        "total": total
    };

}

DetailPdam detailPdamFromJson(String str) => DetailPdam.fromJson(json.decode(str));

String detailPdamToJson(DetailPdam data) => json.encode(data.toJson());

class DetailPdam {
    List<DetailData> data;
    String message;

    DetailPdam({
        this.data,
        this.message,
    });

    factory DetailPdam.fromJson(Map<String, dynamic> json) => DetailPdam(
        data: List<DetailData>.from(json["data"].map((x) => DetailData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class DetailData {
    int id;
    String namaPelanggan;
    String noPelanggan;
    String namaWilayah;
    int tagihan;
    int adminFee;
    int total;
    DateTime periode;
    int walletId;
    int userId;

    DetailData({
        this.id,
        this.namaPelanggan,
        this.noPelanggan,
        this.namaWilayah,
        this.tagihan,
        this.adminFee,
        this.total,
        this.periode,
        this.walletId,
        this.userId
    });

    factory DetailData.fromJson(Map<String, dynamic> json) => DetailData(
        id: json["id"],
        namaPelanggan: json["nama_pelanggan"],
        noPelanggan: json["no_pelanggan"],
        namaWilayah: json["nama_wilayah"],
        tagihan: json["tagihan"],
        adminFee: json["admin_fee"],
        total: json["total"],
        periode: DateTime.parse(json["periode"]),
        walletId: json["walletId"],
        userId: json["userId"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pelanggan": namaPelanggan,
        "no_pelanggan": noPelanggan,
        "nama_wilayah": namaWilayah,
        "tagihan": tagihan,
        "admin_fee": adminFee,
        "total": total,
        "periode": periode.toIso8601String(),
        "userId": userId,
        "walletId": walletId
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
