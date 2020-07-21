import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/promo/detailpromo.dart';
import 'package:flutter/material.dart';

class Promo extends StatefulWidget {
  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  final imgPromosi = [
    {
      "id": 1,
      "img": "promo",
      "detailImg": "detailPromo",
      "title":
          "Voucher beli 1 gratis 1 setiap pembelian Paket Hemat / PaNas gratis PaNas 1 di McDonalds",
      "desc":
          "GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku diseluruh restoran McD di Indonesia.",
      "berlaku": "30 April 2020",
      "sk": {
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia"
      }
    },
    {
      "id": 2,
      "img": "promo",
      "detailImg": "detailPromo",
      "title":
          "Voucher beli 1 gratis 1 setiap pembelian Paket Hemat / PaNas gratis PaNas 1 di McDonalds",
      "desc":
          "GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku diseluruh restoran McD di Indonesia.",
      "berlaku": "30 April 2020",
      "sk": {
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia"
      }
    },
    {
      "id": 3,
      "img": "promo",
      "detailImg": "detailPromo",
      "title":
          "Voucher beli 1 gratis 1 setiap pembelian Paket Hemat / PaNas gratis PaNas 1 di McDonalds",
      "desc":
          "GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku diseluruh restoran McD di Indonesia.",
      "berlaku": "30 April 2020",
      "sk": {
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia"
      }
    },
    {
      "id": 4,
      "img": "promo",
      "detailImg": "detailPromo",
      "title":
          "Voucher beli 1 gratis 1 setiap pembelian Paket Hemat / PaNas gratis PaNas 1 di McDonalds",
      "desc":
          "GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku diseluruh restoran McD di Indonesia.",
      "berlaku": "30 April 2020",
      "sk": {
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia",
        "Gratis PaNas 1 setiap pembelian Paket Hemat dan GRATIS PaNas 1 setiap pembelian Paket Hemat apapun hanya di McDonald's. Promo ini hanya sampai 30 April 2020. Berlaku di seluruh restoran McD di Indonesia"
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new LandingPage()));
                }),
            backgroundColor: Colors.white,
            title: Text(
              "Info dan Promo Spesial",
              style: TextStyle(color: Colors.black),
            )),
        body: ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount: imgPromosi.length,
            itemBuilder: (context, i) {
              return Container(
                  padding: EdgeInsets.all(3),
                  height: 180,
                  width: double.maxFinite,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new DetailPromosi(detailImg: "${imgPromosi[i]['detailImg']}", title: "${imgPromosi[i]['title']}", desc: "${imgPromosi[i]['desc']}", berlaku: "${imgPromosi[i]['berlaku']}", sk: "${imgPromosi[i]['sk']}")));
                      },
                      child: Image.asset(
                        'lib/src/assets/${imgPromosi[i]['img']}.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ));
            }));
  }
}
