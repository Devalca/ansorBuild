import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    List<DataWallet> data;
    String message;

    Wallet({
        this.data,
        this.message,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        data: List<DataWallet>.from(json["data"].map((x) => DataWallet.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class DataWallet {
    int walletId;
    int userId;
    String namaPemilik;
    String noHp;
    int saldoAwal;
    int saldoAkhir;

    DataWallet({
        this.walletId,
        this.userId,
        this.namaPemilik,
        this.noHp,
        this.saldoAwal,
        this.saldoAkhir,
    });

    factory DataWallet.fromJson(Map<String, dynamic> json) => DataWallet(
        walletId: json["walletId"],
        userId: json["userId"],
        namaPemilik: json["nama_pemilik"],
        noHp: json["no_hp"],
        saldoAwal: json["saldo_awal"],
        saldoAkhir: json["saldo_akhir"],
    );

    Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "userId": userId,
        "nama_pemilik": namaPemilik,
        "no_hp": noHp,
        "saldo_awal": saldoAwal,
        "saldo_akhir": saldoAkhir,
    };
}
