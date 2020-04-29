import 'dart:convert';

Katalog katalogFromJson(String str) => Katalog.fromJson(json.decode(str));

String katalogToJson(Katalog data) => json.encode(data.toJson());

class Katalog {
    List<DataKatalog> data;
    String message;

    Katalog({
        this.data,
        this.message,
    });

    factory Katalog.fromJson(Map<String, dynamic> json) => Katalog(
        data: List<DataKatalog>.from(json["data"].map((x) => DataKatalog.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class DataKatalog {
    int sellerId;
    String namaToko;
    String lokasiToko;
    List<Product> products;

    DataKatalog({
        this.sellerId,
        this.namaToko,
        this.lokasiToko,
        this.products,
    });

    factory DataKatalog.fromJson(Map<String, dynamic> json) => DataKatalog(
        sellerId: json["sellerId"],
        namaToko: json["nama_toko"],
        lokasiToko: json["lokasi_toko"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sellerId": sellerId,
        "nama_toko": namaToko,
        "lokasi_toko": lokasiToko,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    int produkId;
    String namaProduk;
    int hargaProduk;
    String deskripsiProduk;
    List<Photo> photos;

    Product({
        this.produkId,
        this.namaProduk,
        this.hargaProduk,
        this.deskripsiProduk,
        this.photos,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        produkId: json["produkId"],
        namaProduk: json["nama_produk"],
        hargaProduk: json["harga_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "produkId": produkId,
        "nama_produk": namaProduk,
        "harga_produk": hargaProduk,
        "deskripsi_produk": deskripsiProduk,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    String photo;

    Photo({
        this.photo,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "photo": photo,
    };
}
