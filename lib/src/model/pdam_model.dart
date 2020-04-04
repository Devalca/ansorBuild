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
    int walletId;
    int userId;
    String noPelanggan;
    String namaPelanggan;
    String namaWilayah;

    PostPdam({
      this.userId,
      this.walletId,
        this.noPelanggan,
        this.namaPelanggan,
        this.namaWilayah,
    });

    factory PostPdam.fromJson(Map<String, dynamic> json) => PostPdam(
                      walletId: json["walletId"],
        userId: json["userId"],
        noPelanggan: json["no_pelanggan"],
        namaPelanggan: json["nama_pelanggan"],
        namaWilayah: json["nama_wilayah"],

    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "walletId": walletId,
        "no_pelanggan": noPelanggan,
        "nama_pelanggan": namaPelanggan,
        "nama_wilayah": namaWilayah,
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

DetailTrans detailTransFromJson(String str) => DetailTrans.fromJson(json.decode(str));

String detailTransToJson(DetailTrans data) => json.encode(data.toJson());

class DetailTrans {
    List<PdamTrans> data;
    String message;

    DetailTrans({
        this.data,
        this.message,
    });

    factory DetailTrans.fromJson(Map<String, dynamic> json) => DetailTrans(
        data: List<PdamTrans>.from(json["data"].map((x) => PdamTrans.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class PdamTrans {
    int id;
    String noPelanggan;
    String namaPelanggan;
    DateTime periode;
    String namaWilayah;
    int tagihan;
    int total;
    DateTime tglBayar;
    String noTransaksi;

    PdamTrans({
        this.id,
        this.noPelanggan,
        this.namaPelanggan,
        this.periode,
        this.namaWilayah,
        this.tagihan,
        this.total,
        this.tglBayar,
        this.noTransaksi,
    });

    factory PdamTrans.fromJson(Map<String, dynamic> json) => PdamTrans(
        id: json["id"],
        noPelanggan: json["no_pelanggan"],
        namaPelanggan: json["nama_pelanggan"],
        periode: DateTime.parse(json["periode"]),
        namaWilayah: json["nama_wilayah"],
        tagihan: json["tagihan"],
        total: json["total"],
        tglBayar: DateTime.parse(json["tgl_bayar"]),
        noTransaksi: json["no_transaksi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_pelanggan": noPelanggan,
        "nama_pelanggan": namaPelanggan,
        "periode": periode.toIso8601String(),
        "nama_wilayah": namaWilayah,
        "tagihan": tagihan,
        "total": total,
        "tgl_bayar": tglBayar.toIso8601String(),
        "no_transaksi": noTransaksi,
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