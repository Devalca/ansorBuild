import 'dart:convert';

Histori historiFromJson(String str) => Histori.fromJson(json.decode(str));

String historiToJson(Histori data) => json.encode(data.toJson());

class Histori {
    Histori({
        this.data,
        this.message,
    });

    List<DataHistori> data;
    String message;

    factory Histori.fromJson(Map<String, dynamic> json) => Histori(
        data: List<DataHistori>.from(json["data"].map((x) => DataHistori.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class DataHistori {
    DataHistori({
        this.id,
        this.userId,
        this.walletId,
        this.idTrx,
        this.label,
        this.nominalTrx,
        this.deskripsi,
        this.tglTrx,
    });

    int id;
    int userId;
    int walletId;
    int idTrx;
    String label;
    int nominalTrx;
    String deskripsi;
    DateTime tglTrx;

    factory DataHistori.fromJson(Map<String, dynamic> json) => DataHistori(
        id: json["id"],
        userId: json["userId"],
        walletId: json["walletId"],
        idTrx: json["idTrx"],
        label: json["label"],
        nominalTrx: json["nominalTrx"],
        deskripsi: json["deskripsi"],
        tglTrx: DateTime.parse(json["tglTrx"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "walletId": walletId,
        "idTrx": idTrx,
        "label": label,
        "nominalTrx": nominalTrx,
        "deskripsi": deskripsi,
        "tglTrx": tglTrx.toIso8601String(),
    };
}
